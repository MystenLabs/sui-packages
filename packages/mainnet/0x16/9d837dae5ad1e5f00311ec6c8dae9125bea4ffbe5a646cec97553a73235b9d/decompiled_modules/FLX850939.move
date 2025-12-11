module 0x169d837dae5ad1e5f00311ec6c8dae9125bea4ffbe5a646cec97553a73235b9d::FLX850939 {
    struct FLX850939 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLX850939, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FLX850939>(arg0, 9, 0x1::string::utf8(b"FLX850939"), 0x1::string::utf8(b"Flexible Test 1765472850939"), 0x1::string::utf8(b"A flexible supply test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FLX850939>>(0x2::coin_registry::finalize<FLX850939>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLX850939>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLX850939>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLX850939>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

