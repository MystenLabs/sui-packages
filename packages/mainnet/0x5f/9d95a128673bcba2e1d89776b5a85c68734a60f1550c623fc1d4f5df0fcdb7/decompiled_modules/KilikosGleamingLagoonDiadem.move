module 0x5f9d95a128673bcba2e1d89776b5a85c68734a60f1550c623fc1d4f5df0fcdb7::KilikosGleamingLagoonDiadem {
    struct KILIKOSGLEAMINGLAGOONDIADEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILIKOSGLEAMINGLAGOONDIADEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILIKOSGLEAMINGLAGOONDIADEM>(arg0, 0, b"COS", b"Kiliko's Gleaming Lagoon Diadem", b"Sleep now... in the arms of...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Kilikos_Gleaming_Lagoon_Diadem.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KILIKOSGLEAMINGLAGOONDIADEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILIKOSGLEAMINGLAGOONDIADEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

