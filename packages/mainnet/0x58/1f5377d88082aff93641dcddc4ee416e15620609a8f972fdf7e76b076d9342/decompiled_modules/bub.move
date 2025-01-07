module 0x581f5377d88082aff93641dcddc4ee416e15620609a8f972fdf7e76b076d9342::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUB>(arg0, 9, b"BUB", b"Bubble", b"Bubble trubble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09fa706d-0486-403f-a18f-707a4e69dc59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

