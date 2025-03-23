module 0xaa9096b204eb43d2da5870ccfb33fb81daa1885f9cecadf4f514b8c62fbe940d::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct ExtendedCoinMetadata has key {
        id: 0x2::object::UID,
        twitter: vector<u8>,
        telegram: vector<u8>,
        website: vector<u8>,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"Orra", b"Orangu", b"An orange simply", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.x.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        let v2 = ExtendedCoinMetadata{
            id       : 0x2::object::new(arg1),
            twitter  : b"https://www.x.com",
            telegram : b"",
            website  : b"https://www.x.com",
        };
        0x2::transfer::transfer<ExtendedCoinMetadata>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

