module 0x44b1f3874efd5ca76ced3ca536f6b8afe5a8e1be6f159501e6deedcf4867b8fb::news {
    struct NEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWS>(arg0, 9, b"NEWS", b"Baru", b"Baru ni bos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a73270d4-43c9-4d6f-9bb2-24dddca30c6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

