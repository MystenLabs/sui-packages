module 0xf4fe4fe2acc593e4c453db57b32336317c610c27207592f69ae35b37967ad221::kamala {
    struct KAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA>(arg0, 9, b"KAMALA", b"POTUS", b"MAGA Hedge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f058685-b154-4d58-82e8-2c2ca8034e1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

