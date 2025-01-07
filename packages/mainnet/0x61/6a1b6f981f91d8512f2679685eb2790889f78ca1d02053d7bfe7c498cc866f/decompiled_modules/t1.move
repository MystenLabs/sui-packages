module 0x616a1b6f981f91d8512f2679685eb2790889f78ca1d02053d7bfe7c498cc866f::t1 {
    struct T1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1>(arg0, 9, b"T1", b"T1 ", b"T1 Champion 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d23d4cb-9214-436f-820d-f46de5601242.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1>>(v1);
    }

    // decompiled from Move bytecode v6
}

