module 0x6d16001615ff053ec0262baf4a422f160f99dbcf024ec15d48499f06dde2588c::stv {
    struct STV has drop {
        dummy_field: bool,
    }

    fun init(arg0: STV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STV>(arg0, 6, b"STV", b"sui on tv", b"SUI TV is a type of meme coin built on the Sui blockchain platform !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_17_ec49c8b145.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STV>>(v1);
    }

    // decompiled from Move bytecode v6
}

