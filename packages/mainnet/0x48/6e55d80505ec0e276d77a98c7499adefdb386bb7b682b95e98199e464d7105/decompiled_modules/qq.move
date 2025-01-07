module 0x486e55d80505ec0e276d77a98c7499adefdb386bb7b682b95e98199e464d7105::qq {
    struct QQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQ>(arg0, 6, b"QQ", b"Q", b"QQQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_04_04_22_35_39_da43aacbc2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

