module 0x3740d1b6a98ec2e2bd8911d832eb758a474949c524d65a10871780dc424561cd::heart_beat {
    struct HEART_BEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEART_BEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEART_BEAT>(arg0, 9, b"HEART_BEAT", b"Heart", b"Heart is a meme coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0679407b-4b99-4fa5-a6b8-6716d632d56f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEART_BEAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEART_BEAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

