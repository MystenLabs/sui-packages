module 0x479cb40227f53aae39c30521eff3d576e1f120ee19713f87d7435dd497de9d18::icbm {
    struct ICBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICBM>(arg0, 6, b"ICBM", b"Intercontinental Ballistic Missiles", b"Intercontinental Ballistic Missiles Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/inbound_icbm_vector_68580_07ef5af517.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICBM>>(v1);
    }

    // decompiled from Move bytecode v6
}

