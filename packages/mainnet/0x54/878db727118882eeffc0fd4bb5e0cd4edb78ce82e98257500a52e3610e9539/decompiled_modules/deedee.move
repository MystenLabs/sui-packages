module 0x54878db727118882eeffc0fd4bb5e0cd4edb78ce82e98257500a52e3610e9539::deedee {
    struct DEEDEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEDEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEDEE>(arg0, 6, b"DEEDEE", b"DeeDee The Big Dick", b"DeeDee The Big Dick On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TFYFJUKGI_OASDASDASDAS_95ffd7e324.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEDEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEDEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

