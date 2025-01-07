module 0x1e8e96ddb53567194c1bc5cac304d33cb80bf64a8ed56c1e85e0469650086cbd::owne {
    struct OWNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNE>(arg0, 9, b"OWNE", b"jdnd", b"jdndbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea95cf18-5e02-42c5-8ef6-315838263a6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

