module 0xcb06281ce5d460af75300f02436069febb8fb809a6b342c26b9236b7aff9f65a::amc {
    struct AMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMC>(arg0, 6, b"AMC", b"AMC ON SUI", b"AMC THEATERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7748_a274f93d9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

