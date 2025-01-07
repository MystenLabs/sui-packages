module 0x70a826aadf58518cd8ee7a2b1ca845501a810802236a4b43c302b1e846a6e520::bortal {
    struct BORTAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORTAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORTAL>(arg0, 6, b"BORTAL", b"Bortal Sui", b"Any chain. Any gain. $BORTAL for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BORTAL_8be3675c28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORTAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORTAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

