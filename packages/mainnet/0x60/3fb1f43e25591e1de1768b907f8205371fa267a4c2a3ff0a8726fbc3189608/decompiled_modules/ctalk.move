module 0x603fb1f43e25591e1de1768b907f8205371fa267a4c2a3ff0a8726fbc3189608::ctalk {
    struct CTALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTALK>(arg0, 6, b"CTALK", b"Chain Talk", b"Decentralized spaces platform. Create secure chat rooms using your wallet and share invite links effortlessly. Private, trustless and secure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kb_P_Yxm_Uj_400x400_542a924e5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

