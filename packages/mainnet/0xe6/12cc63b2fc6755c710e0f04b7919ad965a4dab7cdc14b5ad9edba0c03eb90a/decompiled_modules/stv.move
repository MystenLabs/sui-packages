module 0xe612cc63b2fc6755c710e0f04b7919ad965a4dab7cdc14b5ad9edba0c03eb90a::stv {
    struct STV has drop {
        dummy_field: bool,
    }

    fun init(arg0: STV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STV>(arg0, 6, b"STV", b"Sui On TV", b"SUI TV is a type of meme coin built on the Sui blockchain platform !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_17_a8afc4163d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STV>>(v1);
    }

    // decompiled from Move bytecode v6
}

