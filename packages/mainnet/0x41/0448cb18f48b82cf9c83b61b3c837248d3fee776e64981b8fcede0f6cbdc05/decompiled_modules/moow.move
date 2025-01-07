module 0x410448cb18f48b82cf9c83b61b3c837248d3fee776e64981b8fcede0f6cbdc05::moow {
    struct MOOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOW>(arg0, 6, b"MOOW", b"Moowhale", b"MOoWhale is The King Sea of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_93ded34ab0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

