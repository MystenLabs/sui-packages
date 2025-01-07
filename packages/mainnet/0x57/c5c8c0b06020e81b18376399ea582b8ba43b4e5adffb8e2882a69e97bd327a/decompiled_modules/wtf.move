module 0x57c5c8c0b06020e81b18376399ea582b8ba43b4e5adffb8e2882a69e97bd327a::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 6, b"Wtf", b"epstein trump", b"epstein and trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986711158.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

