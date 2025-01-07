module 0x4b6b9d609fc732ad31a2b2f5b2aca433a1794004d781556435533472b3753c6f::turbocow {
    struct TURBOCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOCOW>(arg0, 6, b"Turbocow", b"TurboCow", b"muuuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988948650.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOCOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOCOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

