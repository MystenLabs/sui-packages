module 0x534e2f39211525ca721df7e5d5fc4449984cc43db528d99333fb8bb1e6fc91be::pkin {
    struct PKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKIN>(arg0, 6, b"PKIN", b"PumpKin", b"Pumptober Pumpkin What ever juust Pump it!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/db997a1e_79fe_451f_87dc_3ef48b69391d_3caa434ea2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

