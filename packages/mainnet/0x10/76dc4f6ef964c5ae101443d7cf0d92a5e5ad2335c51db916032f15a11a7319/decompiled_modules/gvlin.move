module 0x1076dc4f6ef964c5ae101443d7cf0d92a5e5ad2335c51db916032f15a11a7319::gvlin {
    struct GVLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GVLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GVLIN>(arg0, 6, b"GVLIN", b"Geeked vs. Locked In", b"Are you geeked or locked in?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6756_1_0421f9815d.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GVLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GVLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

