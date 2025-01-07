module 0x6f7c55a2138236104026d8c061557c4f1114956adaca549622e931f0ca444439::a43245 {
    struct A43245 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A43245, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A43245>(arg0, 9, b"A43245", b"fdfg", b"435", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8880a50d-f2d9-480a-9a52-948435012193.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A43245>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A43245>>(v1);
    }

    // decompiled from Move bytecode v6
}

