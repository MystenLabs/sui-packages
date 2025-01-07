module 0xc1be6591ee22946591df9320781102943ff8e2d986162d97f08e6fea9882783d::master {
    struct MASTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASTER>(arg0, 6, b"MASTER", b"Chess master", b"the master is the game changer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_Ykb_RDMLT_1729013101942_raw_0d1058fc4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

