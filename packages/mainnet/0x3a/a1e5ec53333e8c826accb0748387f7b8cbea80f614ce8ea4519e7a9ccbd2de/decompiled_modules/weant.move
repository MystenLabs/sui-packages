module 0x3aa1e5ec53333e8c826accb0748387f7b8cbea80f614ce8ea4519e7a9ccbd2de::weant {
    struct WEANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEANT>(arg0, 9, b"WEANT", b"Ants", b"It's good narrative and it's very good meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c544224-ff30-4245-955c-2d1220f13fb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

