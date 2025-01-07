module 0x29347cc61e679443b82a5cc7a5af253559cbbfafa09a1e0f17a86be1a2290b93::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 6, b"Rocky", b"Rocky On Wheels", x"5370656369616c206e6565647320636174732043414e206861766520616e20616d617a696e67207175616c697479206f66206c696665202120526f636b7920696e7374616772616d3a68747470733a2f2f7777772e696e7374616772616d2e636f6d2f726f636b795f6f6e776865656c732f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W5_D_Bqjs9_Pmye_Gyb_B_Dtkn_Ee_FV_19s42f9_Pxh3x_L_Smp_Ta_ME_774f7c5b8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

