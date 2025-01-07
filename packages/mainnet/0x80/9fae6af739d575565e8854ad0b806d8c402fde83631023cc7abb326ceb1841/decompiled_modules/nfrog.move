module 0x809fae6af739d575565e8854ad0b806d8c402fde83631023cc7abb326ceb1841::nfrog {
    struct NFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFROG>(arg0, 6, b"NFrog", b"Ninja Frog", b"nin nin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731091981133.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

