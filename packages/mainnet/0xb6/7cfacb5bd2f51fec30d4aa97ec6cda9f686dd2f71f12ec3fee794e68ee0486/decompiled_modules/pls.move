module 0xb67cfacb5bd2f51fec30d4aa97ec6cda9f686dd2f71f12ec3fee794e68ee0486::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 6, b"PLS", b"Pleasance", b"Architecture & Building Construction token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/28k4J3TQ/AF4-C6-D93-5-C07-4-B08-8961-3549-C606-B092.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

