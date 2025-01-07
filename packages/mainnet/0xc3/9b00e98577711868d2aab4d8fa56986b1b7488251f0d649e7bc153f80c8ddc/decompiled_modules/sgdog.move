module 0xc39b00e98577711868d2aab4d8fa56986b1b7488251f0d649e7bc153f80c8ddc::sgdog {
    struct SGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGDOG>(arg0, 6, b"SGDOG", b"Squid Game Dog", b"Who is ready for Squid game?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gfw_V6q_LXUAES_Ip_Z_e741cd1626.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

