module 0xf841365be80d788a347782ac855975001b2b57f614fe96568c8f40c34b3910ff::puffd {
    struct PUFFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFD>(arg0, 6, b"PuffD", b"Smoking Dog", b"One day ago, I gave up smoking, and I'm smoke-free now! Arf! Come buy with me, PuffD. arf!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732146808417.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUFFD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

