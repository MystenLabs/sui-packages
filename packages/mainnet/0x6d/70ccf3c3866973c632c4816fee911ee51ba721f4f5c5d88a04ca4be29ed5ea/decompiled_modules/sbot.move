module 0x6d70ccf3c3866973c632c4816fee911ee51ba721f4f5c5d88a04ca4be29ed5ea::sbot {
    struct SBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOT>(arg0, 9, b"Sbot", b"suiBot", b"This character is handcrafted from radio parts. The image is processed using artificial intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/748e355e902cb846a287e9d26887695cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

