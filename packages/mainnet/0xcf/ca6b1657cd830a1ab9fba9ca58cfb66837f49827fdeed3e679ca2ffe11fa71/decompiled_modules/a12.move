module 0xcfca6b1657cd830a1ab9fba9ca58cfb66837f49827fdeed3e679ca2ffe11fa71::a12 {
    struct A12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A12>(arg0, 9, b"A12", b"Wawa", b"This is meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa81c4f0-eb0d-4adb-9795-42c5f1c5ba49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A12>>(v1);
    }

    // decompiled from Move bytecode v6
}

