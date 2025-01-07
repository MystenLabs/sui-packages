module 0x745c2356bc2fb00f529e7f32269a3a2d5a9b2e3aa30989ccf82ce49619907d4f::tbip {
    struct TBIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBIP>(arg0, 9, b"TBIP", b"TienBipHP", b"Tien bip meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4c4a6ac-134a-4b35-a2f9-87e3f4ea94bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

