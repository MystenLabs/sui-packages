module 0x26526d40c905dfa63b892c9e672af111987c93fe89aa9acefb9fccb4a5df97a9::zuiggy {
    struct ZUIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUIGGY>(arg0, 6, b"ZUIGGY", b"Zuiggy The Ghost", b"Zuiggy The Mischievous Ghost! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_04_at_11_36_07_AM_1_c557aa4ed5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

