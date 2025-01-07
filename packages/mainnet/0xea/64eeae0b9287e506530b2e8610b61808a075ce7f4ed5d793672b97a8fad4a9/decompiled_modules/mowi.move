module 0xea64eeae0b9287e506530b2e8610b61808a075ce7f4ed5d793672b97a8fad4a9::mowi {
    struct MOWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOWI>(arg0, 6, b"Mowi", b"IM MOWI", x"4d6f7669206f6e20537569207c20417274206279200a406d6f6d6f6368696b615f686969726f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_Ot9t_Jx_L_400x400_c31178c140.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

