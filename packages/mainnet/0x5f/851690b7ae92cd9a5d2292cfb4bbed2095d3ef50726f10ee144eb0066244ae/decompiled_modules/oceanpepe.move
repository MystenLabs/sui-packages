module 0x5f851690b7ae92cd9a5d2292cfb4bbed2095d3ef50726f10ee144eb0066244ae::oceanpepe {
    struct OCEANPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEANPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEANPEPE>(arg0, 6, b"OCEANPEPE", b"OceanPepe", b"The Most Memorable Coin On Land, Becomes The Most Memorable Coin Under Water. The Cats, Dogs, Land Pepe Have Had Their Day. It's Time For Ocean Pepe To Take Reign.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_N_Ukthi9_JP_978_N_s_1b19fda075.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEANPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEANPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

