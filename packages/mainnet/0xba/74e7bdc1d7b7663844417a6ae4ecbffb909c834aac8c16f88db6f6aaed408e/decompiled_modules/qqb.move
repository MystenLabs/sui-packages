module 0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb {
    struct QQB has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQB>(arg0, 8, b"QQB", b"QQB", b"my qqb coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pic.nximg.cn/file/20150505/20972157_223515197461_2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QQB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QQB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

