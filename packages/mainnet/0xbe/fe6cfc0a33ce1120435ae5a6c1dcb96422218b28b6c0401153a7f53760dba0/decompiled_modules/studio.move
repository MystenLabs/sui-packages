module 0xbefe6cfc0a33ce1120435ae5a6c1dcb96422218b28b6c0401153a7f53760dba0::studio {
    struct STUDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUDIO>(arg0, 9, b"STUDIO", b"CartelStu", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d93202e-f137-4fb9-9688-4f5e764c370b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STUDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

