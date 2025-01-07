module 0x3da151ec6e05eae0320e056c0239112bcc11e4e3cc8195bdfec51b212df41db3::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUII>(arg0, 6, b"SUII", b"Ronaldo", b"muchas gracias aficin esto es para vosotros $SUIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_92732be1fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

