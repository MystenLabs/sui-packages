module 0xbbdc7f07144acadb5e300a68d7ed288fb50cdee0a76067290bb708e0e7592dba::aye {
    struct AYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYE>(arg0, 6, b"AYE", b"Aye Aye coin", x"4141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414159452d4159450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054202_a8b2076321.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

