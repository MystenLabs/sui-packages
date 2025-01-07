module 0xad13d9109986e40e304bdea8690c92d1ee477e21a3a9ae74ba2075be14d88596::monkey1 {
    struct MONKEY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY1>(arg0, 6, b"Monkey1", b"Monkey", b"Monkey Monkey Monkey Monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730894242457.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKEY1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

