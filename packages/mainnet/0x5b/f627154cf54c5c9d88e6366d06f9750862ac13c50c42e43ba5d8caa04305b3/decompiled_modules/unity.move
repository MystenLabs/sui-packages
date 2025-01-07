module 0x5bf627154cf54c5c9d88e6366d06f9750862ac13c50c42e43ba5d8caa04305b3::unity {
    struct UNITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNITY>(arg0, 9, b"UNITY", b"Siliya44", b"It is good project and utylity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b629653e-9123-405a-8426-d5c041166b25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

