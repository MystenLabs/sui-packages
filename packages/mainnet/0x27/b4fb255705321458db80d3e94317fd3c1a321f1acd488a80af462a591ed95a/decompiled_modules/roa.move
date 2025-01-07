module 0x27b4fb255705321458db80d3e94317fd3c1a321f1acd488a80af462a591ed95a::roa {
    struct ROA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROA>(arg0, 9, b"ROA", b"ROAD ", b"The new way to future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6247469c-9ad6-420a-9115-5f86c3e170f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROA>>(v1);
    }

    // decompiled from Move bytecode v6
}

