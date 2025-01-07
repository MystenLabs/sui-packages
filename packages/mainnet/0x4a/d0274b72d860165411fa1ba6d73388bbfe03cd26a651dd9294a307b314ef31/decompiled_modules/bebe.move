module 0x4ad0274b72d860165411fa1ba6d73388bbfe03cd26a651dd9294a307b314ef31::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBE>(arg0, 9, b"bebe", b"bebe", b"bebe is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/Q9WXybs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEBE>(&mut v2, 6942000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

