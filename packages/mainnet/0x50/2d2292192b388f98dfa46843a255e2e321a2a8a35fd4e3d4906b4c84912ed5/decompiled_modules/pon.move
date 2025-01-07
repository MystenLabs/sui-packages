module 0x502d2292192b388f98dfa46843a255e2e321a2a8a35fd4e3d4906b4c84912ed5::pon {
    struct PON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PON>(arg0, 9, b"PON", b"PONPON", b"PONPONPON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d629d12-2000-4c6a-a894-cb91e93c72f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PON>>(v1);
    }

    // decompiled from Move bytecode v6
}

