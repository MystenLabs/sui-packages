module 0xbd4f71353ac0973aef606961959e52f273700f18ddfbd0500bcc534b49c46442::shoki {
    struct SHOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOKI>(arg0, 6, b"SHOKI", b"Sui Shoki", b"Shoki is more than currency, together we are unstoppable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002782_579d06ee0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

