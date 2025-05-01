module 0xb960d73c35b0ccfe76ade225aa2fb89201bc68512742897cc3eec68ea07b54ab::apt_sui {
    struct APT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT_SUI>(arg0, 9, b"aptSUI", b"Aptos Staked SUI", b"Aptos Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/77226aee-7cc5-4586-ba0a-91e4889d5c87/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

