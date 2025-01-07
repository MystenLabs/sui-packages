module 0xbee113cdb8fffc83cdf63c0293e59073405fc6b12a73196e389fa5aa1b149b36::ssex {
    struct SSEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSEX>(arg0, 6, b"SSEX", b"Sex on Sui", b"The hottest token of all sui has arrived, sex is part of life and sui is about to be available for over +18s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240922_203845_984_0dabdb98ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

