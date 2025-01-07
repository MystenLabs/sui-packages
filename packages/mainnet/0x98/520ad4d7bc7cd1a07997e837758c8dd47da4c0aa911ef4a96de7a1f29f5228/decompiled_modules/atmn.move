module 0x98520ad4d7bc7cd1a07997e837758c8dd47da4c0aa911ef4a96de7a1f29f5228::atmn {
    struct ATMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATMN>(arg0, 9, b"ATMN", b"AUTUMN", x"456d62726163652074686520626561757479206f662074686520736561736f6e207769746820415554554d4e204d656d65636f696e2c2061207761726d20616e6420656e6368616e74696e67206469676974616c2063757272656e637920696e7370697265642062792074686520636f6c6f727320616e64206d61676963206f6620617574756d6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0dd832c-fd11-409b-8739-ebc1dbeca43c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

