module 0x480c518351b8cfb1e7d6a07d3de67e4769e9f70cecd3c3418758e4f7da829844::bw {
    struct BW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BW>(arg0, 6, b"BW", b"Bagwork", b"B", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1764058175753.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

