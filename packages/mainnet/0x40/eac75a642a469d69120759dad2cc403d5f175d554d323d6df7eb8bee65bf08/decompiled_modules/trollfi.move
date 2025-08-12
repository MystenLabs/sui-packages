module 0x40eac75a642a469d69120759dad2cc403d5f175d554d323d6df7eb8bee65bf08::trollfi {
    struct TROLLFI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TROLLFI>, arg1: 0x2::coin::Coin<TROLLFI>) {
        0x2::coin::burn<TROLLFI>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<TROLLFI>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLFI>>(arg0, @0x0);
    }

    fun init(arg0: TROLLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLFI>(arg0, 6, b"TROLLFI", b"Lofi the Troll", b"Speed on Sui, Spirit of Chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/T9o0UZm.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TROLLFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TROLLFI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

