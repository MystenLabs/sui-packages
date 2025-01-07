module 0xad1c65c2ea43554a54f442fc246ef24abd67c3f673cb8886ea7b95f408dd8d1c::zxczxc {
    struct ZXCZXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXCZXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXCZXC>(arg0, 9, b"ZXCZXC", b"ASDAS", b"SADASQW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfb18174-8159-43ef-90c7-25df34df6578.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXCZXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZXCZXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

