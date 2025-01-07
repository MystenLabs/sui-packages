module 0xc6364cfe5010c66a3cb433ac2fd87142909488996c2e57ed4b4a0d5b200fb9e7::bulltrump {
    struct BULLTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLTRUMP>(arg0, 6, b"BULLTRUMP", b"Bull Trump", b"Making Crypto Great Again, One Bull at a Time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_7x_Zz_T_Xk_AALSH_1_1_c20a31bc05.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

