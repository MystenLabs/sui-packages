module 0xa777b3dde97264fbb8113d5ee03f1c386442e5a65697ed9e01941b202bd0b57e::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 9, b"BUT", b"Sadbutrich", b"Stay rich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afa61441-ef59-4e36-ab45-0b4b01ce4f42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

