module 0x5a7e58649f6a7c95fdd7295c1234dcd7ffc07ab83c448baa560b2d475a58235e::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"Pearl", b"Pearl on Sui", b"Sui Pearl Token is a rare and luminous digital gem, shining bright in the Sui ecosystem. Our mission is to create a treasure trove of value, security, and community-driven growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_Ap3_b_W8_A_And_D3_5df0085ec6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

