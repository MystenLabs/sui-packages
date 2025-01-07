module 0x309e398af4e698e26fb164ec316219b41424923a575de621e95be82235e84530::weasel {
    struct WEASEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEASEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEASEL>(arg0, 6, b"WEASEL", b"WEASEL FLY", x"496e74726f647563696e672057656173656c20666c793a204d656d65204d616769632c205461782d46726565210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_39_b87d6bfd84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEASEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEASEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

