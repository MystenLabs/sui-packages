module 0xf11c026a1377eecb17fe6ea02a3b0c087ed81d29b479558ccd96c2243237bb05::wee {
    struct WEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEE>(arg0, 9, b"WEE", b"Weeders", b"A token to support the legalization of marijuana globally", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4105a33b-611e-4955-86bb-212c6a634ce5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

