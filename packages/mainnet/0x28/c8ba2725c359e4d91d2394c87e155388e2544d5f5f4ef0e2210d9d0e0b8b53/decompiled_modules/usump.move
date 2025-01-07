module 0x28c8ba2725c359e4d91d2394c87e155388e2544d5f5f4ef0e2210d9d0e0b8b53::usump {
    struct USUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUMP>(arg0, 6, b"USUMP", b"Pixel Unicorn", b"Sup whales, meet Pixel, the most profitable unicorn on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_c038995adb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

