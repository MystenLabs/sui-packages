module 0x384a714471254db57fb5fabd37f70870a8d7c47e85cc5626810128b31f623ea::fr {
    struct FR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FR>(arg0, 9, b"FR", b"Yahuhe ", b"Huhu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36bb3fe7-043c-49c0-a0ad-89fa9c3130fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FR>>(v1);
    }

    // decompiled from Move bytecode v6
}

