module 0xbc4a653cba7d2624358aa6e61672b2443b6808bd2cf824887400ccb4dc915298::spunki {
    struct SPUNKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNKI>(arg0, 6, b"SPUNKI", b"Spunki Sui", b"SPUNKI JUST A MEMECOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016415_a11c0c7dfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

