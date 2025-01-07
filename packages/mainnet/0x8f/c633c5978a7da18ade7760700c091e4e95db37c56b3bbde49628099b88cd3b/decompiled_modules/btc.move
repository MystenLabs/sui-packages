module 0x8fc633c5978a7da18ade7760700c091e4e95db37c56b3bbde49628099b88cd3b::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"BITCOIN", b"BITCOIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_b744d1f5ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

