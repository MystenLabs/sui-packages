module 0xe19facf6c518d1e14e27ab5663c34ce8f2c04923500944915153f086a3df768e::adapt {
    struct ADAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAPT>(arg0, 9, b"TTT", b"TTT", b"Test-only Sui fungible token. Metadata and URL are placeholders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.redocn.com/sheji/20240905/keaixiaomaotupian_13402018.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ADAPT>>(0x2::coin::mint<ADAPT>(&mut v2, 1000000000 * 1000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAPT>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAPT>>(v1);
    }

    // decompiled from Move bytecode v7
}

