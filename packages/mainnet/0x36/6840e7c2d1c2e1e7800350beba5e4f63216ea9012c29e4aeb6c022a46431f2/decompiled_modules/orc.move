module 0x366840e7c2d1c2e1e7800350beba5e4f63216ea9012c29e4aeb6c022a46431f2::orc {
    struct ORC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORC>(arg0, 9, b"ORC", b"Orange cat", b"Garfield was not here, this cat is garfield's cousin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72428f58-6462-42c1-9849-97ce29b22582.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORC>>(v1);
    }

    // decompiled from Move bytecode v6
}

