module 0x2fffeaf1b12ec0799aa5a5f654069ceb10498d41abd1b8bedfc55cc15da07e7f::btr {
    struct BTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTR>(arg0, 6, b"BTR", b"BTR", b"BTR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737714133891-btr.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

