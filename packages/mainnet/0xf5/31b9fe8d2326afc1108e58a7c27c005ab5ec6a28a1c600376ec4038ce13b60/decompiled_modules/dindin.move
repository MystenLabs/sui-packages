module 0xf531b9fe8d2326afc1108e58a7c27c005ab5ec6a28a1c600376ec4038ce13b60::dindin {
    struct DINDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINDIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINDIN>(arg0, 6, b"DINDIN", b"DINDIN WHALE", b"Do you dream of becoming a whale?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DINDIN_1e3c8f9c5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINDIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINDIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

