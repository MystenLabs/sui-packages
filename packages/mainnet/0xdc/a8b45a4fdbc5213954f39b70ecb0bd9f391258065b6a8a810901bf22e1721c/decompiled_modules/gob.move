module 0xdca8b45a4fdbc5213954f39b70ecb0bd9f391258065b6a8a810901bf22e1721c::gob {
    struct GOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOB>(arg0, 6, b"GOB", b"gobba", b"Are you based", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/proof_of_based_60860b8fb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

