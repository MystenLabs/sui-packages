module 0xc0935a1c84ca4ba4c6292c4d6dd909b1fb3535422a06c11110f2879172659009::bne {
    struct BNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BNE>(arg0, 6, b"BNE", b"bone", b"Bureaucratic Oversight for National Efficiency..There would be a snapshot airdropping our beloved B.O.N.E NFT AGENTS to top 1000 holders and they will represent the DAO of this project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2025_01_03_at_11_42_19_f92bf259f7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BNE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

