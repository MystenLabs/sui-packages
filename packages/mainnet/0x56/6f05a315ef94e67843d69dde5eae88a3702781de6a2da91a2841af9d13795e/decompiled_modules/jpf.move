module 0x566f05a315ef94e67843d69dde5eae88a3702781de6a2da91a2841af9d13795e::jpf {
    struct JPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPF>(arg0, 6, b"JPF", b"JProof", x"4675747572652041490a4261636b656420627920535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_21_16_42_32_c4644e3e15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

