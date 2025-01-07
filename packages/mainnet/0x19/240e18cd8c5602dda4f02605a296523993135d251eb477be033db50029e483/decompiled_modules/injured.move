module 0x19240e18cd8c5602dda4f02605a296523993135d251eb477be033db50029e483::injured {
    struct INJURED has drop {
        dummy_field: bool,
    }

    fun init(arg0: INJURED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INJURED>(arg0, 6, b"INJURED", b"Injured Jesus", x"486520697320414c49564521200a486520676f7420696e6a757265642062792075206b6e6f772077686f2e2e2e0a427574206865206973206865616c6564206e6f7720616e6420726561647920666f7220746865206e65787420666967687421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jrrsuus_1860dd9bb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INJURED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INJURED>>(v1);
    }

    // decompiled from Move bytecode v6
}

