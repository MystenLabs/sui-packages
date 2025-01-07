module 0x2aaf434d746405816f544b8d666324e8a24c0266a47c36d46bbf677ddbf44368::manatee {
    struct MANATEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANATEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANATEE>(arg0, 6, b"MANATEE", b"Manatee  Underwater", b"Manatee  Underwater at Crystal River", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8qftywrd47y71_5a6ee1a1f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANATEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANATEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

