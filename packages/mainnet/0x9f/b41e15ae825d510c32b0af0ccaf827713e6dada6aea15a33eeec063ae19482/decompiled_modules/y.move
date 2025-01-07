module 0x9fb41e15ae825d510c32b0af0ccaf827713e6dada6aea15a33eeec063ae19482::y {
    struct Y has drop {
        dummy_field: bool,
    }

    fun init(arg0: Y, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Y>(arg0, 9, b"Y", b"Qeqe", b"T", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6882f3a0-ee22-4ecb-883b-b786f4328693.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Y>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Y>>(v1);
    }

    // decompiled from Move bytecode v6
}

