module 0xbb1926c45480496b65d7c604356569c3874677ac2353dd63465b85f743d5adb9::ows {
    struct OWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWS>(arg0, 6, b"OWS", b"OWL ON SUI", b"Welcome to the Owl family! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_122115_333_f9340dde39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

