module 0xad4a94d7ba8340f8cfd7052c2037bf1edbb62370cfb0df787490a6d1dd69bbc8::mcmc {
    struct MCMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCMC>(arg0, 6, b"McMc", b"Little  fox", b"fox      McMc.........", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/261cefa79d7ccf1fc98ec62a6914a25c_preview_mid_ac9eac2bb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

