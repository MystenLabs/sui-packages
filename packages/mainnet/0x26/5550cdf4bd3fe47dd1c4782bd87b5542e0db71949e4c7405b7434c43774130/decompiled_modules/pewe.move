module 0x265550cdf4bd3fe47dd1c4782bd87b5542e0db71949e4c7405b7434c43774130::pewe {
    struct PEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWE>(arg0, 9, b"PEWE", b"PEWE Frog", b"PEWE - the one and only legit FROG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a6e3966-160d-4418-a1e9-e534df3b9e04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

