module 0xad9571b9ab48e11fda5ecd7cf10511587a6ab844dd2422cafc2dcfd45f0f4a5f::max3 {
    struct MAX3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX3>(arg0, 9, b"MAX3", b"max3", b"{\"description\":\"this is an avergae sized description to just test if things are good. \",\"twitter\":\"https://twitter.com/0xfrontman\",\"website\":\"https://max3.xyz\",\"telegram\":\"https://t.me/max3onsui\",\"tags\":[\"gay\",\"happy\",\"wonderful\",\"another\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/a6b96d10-3820-4869-852d-6bd8109ce451.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

