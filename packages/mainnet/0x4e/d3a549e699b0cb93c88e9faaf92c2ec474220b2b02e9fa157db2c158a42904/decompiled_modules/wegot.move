module 0x4ed3a549e699b0cb93c88e9faaf92c2ec474220b2b02e9fa157db2c158a42904::wegot {
    struct WEGOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEGOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEGOT>(arg0, 9, b"WEGOT", b"WAWE", b"WAWE is a meme inspired by the spirit of adventure and freedom with WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/603c0134-7e23-49b7-a4d6-d79fa348254a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEGOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEGOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

