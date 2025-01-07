module 0x38f3ed4dbe4ab148a6439ae90527ae228bb748af90644dbb7d2eaa58527e2e7c::chammy {
    struct CHAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMMY>(arg0, 6, b"CHAMMY", b"Chammy the Chameleon", b"After being abandoned in the jungle since birth, Chammy has been able to remain hidden in Madagascar for a long time. However, feeling that something is missing and driven by a deep longing for family and answers about his past, he has decided to come out and search for his supposed father, Brett on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_d0f08a62d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

