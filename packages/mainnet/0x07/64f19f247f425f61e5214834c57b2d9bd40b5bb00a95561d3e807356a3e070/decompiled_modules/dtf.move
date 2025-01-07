module 0x764f19f247f425f61e5214834c57b2d9bd40b5bb00a95561d3e807356a3e070::dtf {
    struct DTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTF>(arg0, 6, b"DTF", b"Dogtor Fish", b"checking hearbeat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DTF_pic_984fc733f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

