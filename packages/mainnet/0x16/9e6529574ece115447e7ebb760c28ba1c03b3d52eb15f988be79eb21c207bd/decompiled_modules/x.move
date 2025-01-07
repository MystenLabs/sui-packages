module 0x169e6529574ece115447e7ebb760c28ba1c03b3d52eb15f988be79eb21c207bd::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"XHAMSTER", b".................................", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_19_56_13_81525b1e08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X>>(v1);
    }

    // decompiled from Move bytecode v6
}

