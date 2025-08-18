module 0x930b0c097cc1e4b12736b658b0aa746622468c4ec56d4eee0b9db6721ee98b99::gcv {
    struct GCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCV>(arg0, 6, b"GCV", b"GuessCoinV", b"Free 2 step authenticator with Gamify attributes coming soon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755481955785.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

