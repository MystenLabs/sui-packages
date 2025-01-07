module 0x907b7b31f816db7f0547ccd587bc794d0f94d1b86d931e3d83f66cd77c961590::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 9, b"DAWG", b"KAIDAWG", b"KAIDAWG is a black poodle with name Kevin. He is like to chase motorcycle and bark at strangers to ask for belly rubs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f5f506b-c765-48b8-9bcc-0ca5f9800f6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

