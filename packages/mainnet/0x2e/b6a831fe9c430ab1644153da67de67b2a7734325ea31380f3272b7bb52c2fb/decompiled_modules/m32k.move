module 0x2eb6a831fe9c430ab1644153da67de67b2a7734325ea31380f3272b7bb52c2fb::m32k {
    struct M32K has drop {
        dummy_field: bool,
    }

    fun init(arg0: M32K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M32K>(arg0, 9, b"M32K", b"MEMEK", b"With this token you can pay fun and make you fly to heaven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c0c4212-8bfc-4ffd-81c0-623d05d40586.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M32K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M32K>>(v1);
    }

    // decompiled from Move bytecode v6
}

