module 0x8f28b12c66dfcff816303cd340338f9235444628abcfe9cebee4adb94fe669f8::wifhat {
    struct WIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHAT>(arg0, 6, b"Wifhat", b"DogWifHat Sui", b"First meme token on sui by DAVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004694_4ba5497b7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

