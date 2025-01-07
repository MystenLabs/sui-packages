module 0x6acef36781e486b7187ee96935bf538a1aa7065d0a6adf5eabde9142993a6203::k2k {
    struct K2K has drop {
        dummy_field: bool,
    }

    fun init(arg0: K2K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K2K>(arg0, 9, b"K2K", b"KuKu", b"Ok meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b1c97cd-2de9-4128-9875-3472c2e20151.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K2K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K2K>>(v1);
    }

    // decompiled from Move bytecode v6
}

