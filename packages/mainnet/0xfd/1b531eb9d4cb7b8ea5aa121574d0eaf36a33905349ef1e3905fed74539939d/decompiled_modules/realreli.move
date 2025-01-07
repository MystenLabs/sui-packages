module 0xfd1b531eb9d4cb7b8ea5aa121574d0eaf36a33905349ef1e3905fed74539939d::realreli {
    struct REALRELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALRELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALRELI>(arg0, 6, b"RealReli", b"Ai Religion", b"https://www.reddit.com/r/nosleep/comments/11fqm22/we_asked_an_ai_to_create_a_religion_i_did_not/?rdt=59365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731195815295.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALRELI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALRELI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

