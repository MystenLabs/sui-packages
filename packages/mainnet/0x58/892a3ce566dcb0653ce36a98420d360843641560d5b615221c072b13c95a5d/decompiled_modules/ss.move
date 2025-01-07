module 0x58892a3ce566dcb0653ce36a98420d360843641560d5b615221c072b13c95a5d::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 9, b"SS", b"Samsung", b"SSS 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88da6989-68e5-4636-98ed-4b77913f2ab0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

