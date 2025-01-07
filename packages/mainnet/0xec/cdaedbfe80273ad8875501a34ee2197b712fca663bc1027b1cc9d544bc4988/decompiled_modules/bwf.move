module 0xeccdaedbfe80273ad8875501a34ee2197b712fca663bc1027b1cc9d544bc4988::bwf {
    struct BWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWF>(arg0, 9, b"BWF", b"beowulf", b"rare wolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8836ad07-4848-4333-81d6-938e59de19bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

