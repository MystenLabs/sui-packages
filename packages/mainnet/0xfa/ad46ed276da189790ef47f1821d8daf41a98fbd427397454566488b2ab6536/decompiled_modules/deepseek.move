module 0xfaad46ed276da189790ef47f1821d8daf41a98fbd427397454566488b2ab6536::deepseek {
    struct DEEPSEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPSEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPSEEK>(arg0, 9, b"DEEPSEEK", b"TrendALDS", x"57686174206d616b657320446565705365656b207370656369616c2069732074686520636f6d70616e79277320636c61696d207468617420697420776173206275696c742061742061206672616374696f6e206f662074686520636f7374206f6620696e6475737472792d6c656164696e67206d6f64656c73206c696b65204f70656e414920e28094206265636175736520697420757365732066657765722063757474696e672d656467652063686970732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ff0b4c1-b070-439c-9128-d5b3c76c8c7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPSEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEPSEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

