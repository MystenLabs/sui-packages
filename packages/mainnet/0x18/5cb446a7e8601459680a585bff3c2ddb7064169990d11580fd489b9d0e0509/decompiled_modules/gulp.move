module 0x185cb446a7e8601459680a585bff3c2ddb7064169990d11580fd489b9d0e0509::gulp {
    struct GULP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GULP>(arg0, 6, b"GULP", b"GULP on SUI", b"Building a Retro Gaming brand on the SUI Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_F_tr_Mxa_400x400_ec9da83089.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GULP>>(v1);
    }

    // decompiled from Move bytecode v6
}

