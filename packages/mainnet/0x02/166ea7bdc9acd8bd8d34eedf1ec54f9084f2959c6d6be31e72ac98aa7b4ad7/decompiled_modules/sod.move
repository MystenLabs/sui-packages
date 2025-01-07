module 0x2166ea7bdc9acd8bd8d34eedf1ec54f9084f2959c6d6be31e72ac98aa7b4ad7::sod {
    struct SOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOD>(arg0, 6, b"SOD", b"Sui Octopus Dippp", x"4c65742773206c6967687420757020746865207375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_07_52_49_03494153a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

