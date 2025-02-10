module 0xb583156d9bc49ed2396e5da0de28330b01ed1f9afeb8db43a3220a921dd4a1ad::gf {
    struct GF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GF>(arg0, 9, b"GF", b"GalacticFail", b"GalacticFail was born when a space explorer accidentally crashed into a pizza delivery drone, creating the most epic fail in cosmic history. Now, it's a token for all those moments when things go hilariously wrong in space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739211157/rsk4dk7zu56bji97npfc.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

