module 0xeef73adbf4014d71b774a2950541e2b4125823c5ffee757e281967dbcf877536::jay1200 {
    struct JAY1200 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAY1200, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAY1200>(arg0, 9, b"JAY1200", b"Jay", b"Scalability confirmed ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be6934d6-432b-4f98-b4a3-6632bac7b44f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAY1200>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAY1200>>(v1);
    }

    // decompiled from Move bytecode v6
}

