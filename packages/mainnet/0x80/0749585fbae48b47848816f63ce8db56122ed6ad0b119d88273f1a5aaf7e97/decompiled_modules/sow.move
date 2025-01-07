module 0x800749585fbae48b47848816f63ce8db56122ed6ad0b119d88273f1a5aaf7e97::sow {
    struct SOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOW>(arg0, 6, b"SOW", b"SUI ON WATERS", b"#Suis beloved mascot token! Dive into the refreshing world of $WATER, where gains flows!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/15_194cd29e98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

