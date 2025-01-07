module 0xb4e78884d28243df7d842c76a713592303d807413c9fe2e54e41b4458844967a::nuby {
    struct NUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBY>(arg0, 6, b"NUBY", b"Anubis", b"Anubis is the god of death in ancient Egyptian mythology whose name means \"rot\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NUBY_TK_8im_B_Op8i_P3xcgrdp_8f42101d50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

