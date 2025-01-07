module 0x4122f1ae00d32822eb763c2a8efdbb967843f8b2449388cca51f6debce1c360e::suimp {
    struct SUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMP>(arg0, 6, b"SUIMP", b"Suimpanzee", b"Hello I'm $SUIMP - the simp Chimp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_8ab82cd353.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

