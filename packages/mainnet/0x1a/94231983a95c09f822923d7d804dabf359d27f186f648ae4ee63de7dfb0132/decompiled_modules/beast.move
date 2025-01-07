module 0x1a94231983a95c09f822923d7d804dabf359d27f186f648ae4ee63de7dfb0132::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAST>(arg0, 6, b"Beast", b"MrBeast", b"Fan tocen mrBeast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003751_0367020986.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

