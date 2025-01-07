module 0x394feefe16a38b3983ad2653713244c3cf7b54b7f3ccd1df9d511136343ea9bf::we_cool {
    struct WE_COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE_COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE_COOL>(arg0, 9, b"WE_COOL", b"weco", b"got inspired on youtube", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af52c306-f9f3-4565-a062-d47abc035beb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE_COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE_COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

