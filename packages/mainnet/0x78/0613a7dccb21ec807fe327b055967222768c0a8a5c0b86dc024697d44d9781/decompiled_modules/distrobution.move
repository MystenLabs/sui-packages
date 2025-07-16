module 0x780613a7dccb21ec807fe327b055967222768c0a8a5c0b86dc024697d44d9781::distrobution {
    struct DISTROBUTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISTROBUTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISTROBUTION>(arg0, 9, b"DISTRO", b"distrobution", b"just distribution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1783054324748173312/07YzBbzw_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DISTROBUTION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISTROBUTION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

