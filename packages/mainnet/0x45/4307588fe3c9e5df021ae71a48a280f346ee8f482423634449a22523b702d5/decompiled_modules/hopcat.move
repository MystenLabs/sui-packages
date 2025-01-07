module 0x454307588fe3c9e5df021ae71a48a280f346ee8f482423634449a22523b702d5::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HopCat", b"Hop Cat", x"466972737420636174206f6e20486f702046756e200a4c61756e6368696e67206f6e204e6f76656d6265722037", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956261673.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

