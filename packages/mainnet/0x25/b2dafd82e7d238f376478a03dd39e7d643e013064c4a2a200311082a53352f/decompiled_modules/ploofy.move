module 0x25b2dafd82e7d238f376478a03dd39e7d643e013064c4a2a200311082a53352f::ploofy {
    struct PLOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOOFY>(arg0, 6, b"PLOOFY", b"Ploofy the whale", b"https://ploofy.xyz : $PLOOFY is the baby whale thats here to pump, splash, and disrupt the crypto seas. Just pure degen fun. Ready to ride the wave? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_3q_Ner_Xk_AA_52ro_87d801ec54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

