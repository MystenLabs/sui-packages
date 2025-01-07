module 0x637528eb152d0c9bbf62222f3b76352869a6831371b1cab777ec3685ef31ead::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWW>(arg0, 6, b"WWW", b"dsasd", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731255038050.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

