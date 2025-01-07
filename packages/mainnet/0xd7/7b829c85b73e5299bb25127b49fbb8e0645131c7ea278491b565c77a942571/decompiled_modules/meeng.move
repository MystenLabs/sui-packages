module 0xd77b829c85b73e5299bb25127b49fbb8e0645131c7ea278491b565c77a942571::meeng {
    struct MEENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEENG>(arg0, 6, b"MEENG", b"Proud of Meeng", b"MEENG is an innovative memecoin that combines humor and the charm of internet memes in the cryptocurrency world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975297625.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

