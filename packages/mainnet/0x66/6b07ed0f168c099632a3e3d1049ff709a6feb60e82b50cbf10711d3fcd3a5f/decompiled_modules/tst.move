module 0x666b07ed0f168c099632a3e3d1049ff709a6feb60e82b50cbf10711d3fcd3a5f::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 9, b"TST", b"TST on SUI", b"TST LAUNCH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4b5c9bf-ba0a-4e08-8144-499dd8f51add.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST>>(v1);
    }

    // decompiled from Move bytecode v6
}

