module 0x4befd954a227f2f95ce9cfba7700849d848deb66dcfc94528b71ea2aea88a084::meme_coin {
    struct MEME_COIN has drop {
        dummy_field: bool,
    }

    struct MemeCollection has key {
        id: 0x2::object::UID,
        total_supply: u64,
        image_url: 0x2::url::Url,
        treasury_cap: 0x2::coin::TreasuryCap<MEME_COIN>,
    }

    struct MemeOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut MemeCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MEME_COIN> {
        arg0.total_supply = arg0.total_supply + arg1;
        0x2::coin::mint<MEME_COIN>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public fun balance_of(arg0: &0x2::coin::Coin<MEME_COIN>) : u64 {
        0x2::coin::value<MEME_COIN>(arg0)
    }

    public fun create_collection(arg0: 0x2::coin::TreasuryCap<MEME_COIN>, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (MemeCollection, MemeOwnerCap) {
        let v0 = MemeCollection{
            id           : 0x2::object::new(arg3),
            total_supply : arg1,
            image_url    : 0x2::url::new_unsafe_from_bytes(arg2),
            treasury_cap : arg0,
        };
        let v1 = MemeOwnerCap{id: 0x2::object::new(arg3)};
        (v0, v1)
    }

    fun init(arg0: MEME_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_COIN>(arg0, 9, b"MEME", b"Meme Coin", b"A fun meme coin on SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

