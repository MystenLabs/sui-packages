module 0x5b280f2d2f1a61532d2de7392d8bd24adcd8529a96238b5d594be7b1162f4ca7::dg {
    struct DG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DG>(arg0, 9, b"DG", b"rotdog", b"lets take dogs to another level of love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9326ff57-c282-4826-a3da-06d0e1b62cef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DG>>(v1);
    }

    // decompiled from Move bytecode v6
}

