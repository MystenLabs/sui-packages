module 0xa52a698edb024c1b4a3cf4dbea9642a4683644cb13eb3eae57b1acfab69b4199::high {
    struct HIGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGH>(arg0, 6, b"HIGH", b"HIGH PEPE", x"5945502c20484947482e20546865206d6f7374206c69742073756920636861696e206d656d6520746f6b656e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STL_Spz6a_400x400_f24d6c3c18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

