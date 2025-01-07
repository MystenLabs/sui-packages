module 0x337f4ffa133f41cb2f9d3d99acdb9a8c14ad00f8493e18cce5b9c8494909bc96::dan {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN>(arg0, 6, b"Dan", b"LTdan", b"LT Dan from Tampa Florida is going to ride Hurricane Milton into the sunset ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8414_56dcaf359e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

