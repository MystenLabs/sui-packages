module 0xfbd6f75c52046a57bef7e3fa37e358cecc90aa3d638a5e2fa9d64f18740fca29::arigoodboy {
    struct ARIGOODBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIGOODBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIGOODBOY>(arg0, 9, b"ARIGOODBOY", b"ARI", b"Ari it's my doog and this is his meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40280072-0ec7-499e-a52a-0cf709275abf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIGOODBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARIGOODBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

