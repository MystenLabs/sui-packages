module 0xa0132cf1fd1647842f3bbd1dae8ffc70a023c9d02ab82c95dffc5bb452772df7::le {
    struct LE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE>(arg0, 9, b"LE", b"Thanh Thao", b"You", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/641b40ad-0022-4fd7-98c0-8b207c324724.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE>>(v1);
    }

    // decompiled from Move bytecode v6
}

