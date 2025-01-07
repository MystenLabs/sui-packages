module 0x8405b35fa76884d215abf3e859e02458f4d9a16a4a1f7805c8a78953f546165f::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"MOMO SUI", b"MOMO FISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c0d3f1bc4819385597131e4a26152530_1aca6aa75e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

