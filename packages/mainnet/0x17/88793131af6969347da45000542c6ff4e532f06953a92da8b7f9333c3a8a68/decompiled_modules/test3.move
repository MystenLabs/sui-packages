module 0x1788793131af6969347da45000542c6ff4e532f06953a92da8b7f9333c3a8a68::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 6, b"TEST3", b"TEST 3", b"TEST3 ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/064e0fe7-b053-4963-9b46-54009302b8af.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

