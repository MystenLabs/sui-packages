module 0x8df2dd378ad46841d6866fa3f4e30c7b89060a50eecd7861c4e352132d785aaa::c98 {
    struct C98 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C98, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C98>(arg0, 9, b"C98", b"c98`", b"Chia 98 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb9a39df-684f-41f2-8344-bf128e14f109.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C98>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C98>>(v1);
    }

    // decompiled from Move bytecode v6
}

