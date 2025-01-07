module 0x108532da53d246537d10c8ce63248b85fc29b6fb07ec06886ac93e2460a6617f::tor {
    struct TOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOR>(arg0, 9, b"TOR", b"TOR ", b"Token TOR ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a756982b-3c1f-43ab-b30a-d9cde156165d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

