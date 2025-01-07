module 0x4cf75279974c8a248a09f19305c755e4063224c5652cf96e0a0e3f2876a4ace2::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<WEWE>(arg0, 9, b"WEWE", b"Wewe Token", b"Wewe Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.walletapp.waveonsui.com/logos/wewe.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WEWE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEWE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WEWE>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

