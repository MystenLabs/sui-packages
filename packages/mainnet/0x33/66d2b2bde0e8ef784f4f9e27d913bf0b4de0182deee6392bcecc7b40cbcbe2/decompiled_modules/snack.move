module 0x3366d2b2bde0e8ef784f4f9e27d913bf0b4de0182deee6392bcecc7b40cbcbe2::snack {
    struct SNACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNACK>(arg0, 9, b"SNACK", b"SnackCoin", b"How about \"SnackCoin\" (SNCK)?  A quirky, light-hearted cryptocurrency for all your snack-loving needs! Whether you're trading digital doughnuts or investing in virtual pizza slices, SnackCoin will be your deliciously fun token on the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1806438507730132992/YMEvdUYL.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNACK>(&mut v2, 2222222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

