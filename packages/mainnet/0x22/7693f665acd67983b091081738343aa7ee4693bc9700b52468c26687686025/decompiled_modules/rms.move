module 0x227693f665acd67983b091081738343aa7ee4693bc9700b52468c26687686025::rms {
    struct RMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMS>(arg0, 6, b"RMS", b"Remus", b"#GARGOYLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Hu_I_Gh_Xw_AA_7e_QZ_00bba62f5a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

