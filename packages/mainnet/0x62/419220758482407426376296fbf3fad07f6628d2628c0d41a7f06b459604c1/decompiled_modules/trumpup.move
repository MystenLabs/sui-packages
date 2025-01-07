module 0x62419220758482407426376296fbf3fad07f6628d2628c0d41a7f06b459604c1::trumpup {
    struct TRUMPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPUP>(arg0, 6, b"TRUMPUP", b"trumpup", b"Make America great again! Stand with Trump to defend freedom and prosperity. Together, we fight for the future and build a better nation. United we stand, Trump, let's go!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_b9bb3bf3d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

