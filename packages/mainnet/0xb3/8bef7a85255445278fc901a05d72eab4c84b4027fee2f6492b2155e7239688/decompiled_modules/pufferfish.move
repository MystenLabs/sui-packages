module 0xb38bef7a85255445278fc901a05d72eab4c84b4027fee2f6492b2155e7239688::pufferfish {
    struct PUFFERFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFERFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFERFISH>(arg0, 6, b"PUFFERFISH", b"PufferFish", b"Pufferfish ($PUFF)  small but mighty, just like its namesake. This token is ready to inflate and make a splash on the Sui network. Dont underestimate the puff  its packing a punch!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_imagine_a_cartoon_design_of_blue_pufferfish_mascot_l_10578def_d7b4_447c_b6a0_019f3b17f540_2_07cda2c1a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFERFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFERFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

