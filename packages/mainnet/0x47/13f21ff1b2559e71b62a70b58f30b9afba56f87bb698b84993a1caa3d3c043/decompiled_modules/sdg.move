module 0x4713f21ff1b2559e71b62a70b58f30b9afba56f87bb698b84993a1caa3d3c043::sdg {
    struct SDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDG>(arg0, 9, b"SDG", b"SUIDOG", b"SDG Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e8557098bf364bf592d53106d7be53a2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

