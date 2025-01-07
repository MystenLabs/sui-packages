module 0x3585734a4b9d8a77e2f06624d4c3ad1ba3fdf5da08dfb2d20a6436bfd8d4fbed::wwp {
    struct WWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWP>(arg0, 9, b"WWP", b"WEWEPUMPP", b"WEWEPUMP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51ea928a-b672-49b9-8f70-6cc2bd5c8129.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

