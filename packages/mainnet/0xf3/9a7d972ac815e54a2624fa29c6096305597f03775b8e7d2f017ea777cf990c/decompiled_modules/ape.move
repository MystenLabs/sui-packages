module 0xf39a7d972ac815e54a2624fa29c6096305597f03775b8e7d2f017ea777cf990c::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"Always Pray Everyday", b"Always Pray EverydayAlways Pray EverydayAlways Pray EverydayAlways Pray EverydayAlways Pray EverydayAlways Pray EverydayAlways Pray Everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Always_Pray_Everyday_ac56ab8ace.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

