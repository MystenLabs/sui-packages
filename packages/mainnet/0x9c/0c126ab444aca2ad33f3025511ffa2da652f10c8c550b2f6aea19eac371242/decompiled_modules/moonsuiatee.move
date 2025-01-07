module 0x9c0c126ab444aca2ad33f3025511ffa2da652f10c8c550b2f6aea19eac371242::moonsuiatee {
    struct MOONSUIATEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSUIATEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSUIATEE>(arg0, 6, b"MOONSUIATEE", b"Moonsuiatee", b"$MOONSUIATEE, the legendary manatee of Sui who drifts between the ocean and the cosmos, inspiring everyone to dream big and chase after their own crypto moonshot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2ed10c9cd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSUIATEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONSUIATEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

