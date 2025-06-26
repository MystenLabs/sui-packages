module 0xdffb6b1692dbca49e5c4c05c71b2e935f80547099e6f69de94d74227625c157a::dev_buy {
    struct DEV_BUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV_BUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV_BUY>(arg0, 9, b"DB", b"dev buy", b"dev buy com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/5dc234ad-e6a6-44df-890b-56c3f726f0ff.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEV_BUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV_BUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

