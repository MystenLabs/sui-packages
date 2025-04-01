module 0xd9c2f1c3db74198932a02c9c64c58e7f4cfddd8d7c22899556d89fb0cc4e4f6b::suikito {
    struct SUIKITO has drop {
        dummy_field: bool,
    }

    struct SuikitoData has store, key {
        id: 0x2::object::UID,
        telegram: vector<u8>,
        website: vector<u8>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIKITO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 100000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIKITO>>(0x2::coin::mint<SUIKITO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUIKITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKITO>(arg0, 9, b"SUIKITO", b"Suikito Token", x"556e20746f6b656e20706572736f6e6e616c6973c3a9", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKITO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKITO>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = SuikitoData{
            id       : 0x2::object::new(arg1),
            telegram : b"https://t.me/SuikitoPortal",
            website  : b"https://www.suikito.store",
        };
        0x2::transfer::transfer<SuikitoData>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

