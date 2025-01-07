module 0xa97216ce04a33d843a84163ddda6224b964c39493441c5cd1954d32c069a2efb::shadeng {
    struct SHADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADENG>(arg0, 6, b"SHADENG", b"Shark Moo Deng", b"Imagine a hippo with a shark's head- a unique and intriguing creature. This hippo has the sturdy, barrel-shaped body and thick legs typical of a hippo, but instead of the usual wide mouth, it boasts the sleek, streamlined head of a shark, complete with sharp teeth and a dorsal fin. The combination of the hippo's massive build and the shark's predatory features makes for an astonishing and awe-inspiring sight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nwi_B_Rf_Fk4_YV_7djvcmy_Hzom_Nr_Uu4h3r_T_Gev6x25_Gr9_QVN_3b59c0046a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

