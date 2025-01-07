module 0x384f27ea5d61d2e8d76512c38883c7512b4a42ee70bf2344e01e326977c87132::master {
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

