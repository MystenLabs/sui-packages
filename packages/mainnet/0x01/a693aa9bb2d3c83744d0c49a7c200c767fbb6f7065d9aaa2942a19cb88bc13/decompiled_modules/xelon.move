module 0x1a693aa9bb2d3c83744d0c49a7c200c767fbb6f7065d9aaa2942a19cb88bc13::xelon {
    struct XELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: XELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XELON>(arg0, 9, b"XELON", b"X", b"We will change the world of Web 3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bb1361c-e9eb-4a35-9ba7-b41c18b52271.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

