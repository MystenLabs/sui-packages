module 0xe0d2ae379c64e0b0abbb1f86802fedf0287f2b64fa432e8e97a04f73f78e2041::suidan {
    struct SUIDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAN>(arg0, 6, b"SUIDAN", b"LT. Lego Dan", b"Who needs legs when you're riding the Suinami", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241002_182809_749_7cadb229b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

