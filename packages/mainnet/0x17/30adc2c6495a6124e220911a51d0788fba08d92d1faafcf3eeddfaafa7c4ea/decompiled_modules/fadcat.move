module 0x1730adc2c6495a6124e220911a51d0788fba08d92d1faafcf3eeddfaafa7c4ea::fadcat {
    struct FADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FADCAT>(arg0, 6, b"FADCAT", b"Dont fade noo cat", b"Dont fade noooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_195228_26270dd1c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

