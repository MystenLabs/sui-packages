module 0x1195ee900ee4d5446cf2bd968c90bee1688c96ef97b1e50deb861f17685b868b::stv {
    struct STV has drop {
        dummy_field: bool,
    }

    fun init(arg0: STV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STV>(arg0, 6, b"STV", b"SUI ON TV", b"SUI TV is a type of meme coin built on the Sui blockchain platform !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_17_71b3c25af2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STV>>(v1);
    }

    // decompiled from Move bytecode v6
}

