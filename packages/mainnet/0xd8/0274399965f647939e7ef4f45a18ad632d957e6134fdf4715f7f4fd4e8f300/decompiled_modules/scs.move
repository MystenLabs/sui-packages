module 0xd80274399965f647939e7ef4f45a18ad632d957e6134fdf4715f7f4fd4e8f300::scs {
    struct SCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCS>(arg0, 6, b"SCS", b"STAR CAT SUI", x"43617427732066726f6d207468652073746172732c206d6967687420616c726561647920626520737061636520647573742c20796f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GSCM_4k_Mbs_AA_1xed_5676c97368.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

