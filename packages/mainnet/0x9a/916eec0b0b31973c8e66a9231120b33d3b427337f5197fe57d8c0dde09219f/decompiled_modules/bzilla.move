module 0x9a916eec0b0b31973c8e66a9231120b33d3b427337f5197fe57d8c0dde09219f::bzilla {
    struct BZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZILLA>(arg0, 6, b"BZILLA", b"Monster BlueZilla", b"MONSTER BLUE ZILLA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nb_z2_Ozb_S_Wi_J_7_ALD_Nk_Dn_Q_7f9ab8008e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

