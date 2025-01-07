module 0x19c5413f5e00500ef60bee92ef44ac5051628b4781b98f311289960570f4e59f::bzilla {
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

