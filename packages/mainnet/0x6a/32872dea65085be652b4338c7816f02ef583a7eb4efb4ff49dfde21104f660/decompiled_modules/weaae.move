module 0x6a32872dea65085be652b4338c7816f02ef583a7eb4efb4ff49dfde21104f660::weaae {
    struct WEAAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEAAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEAAE>(arg0, 9, b"WEAAE", b"WEA", b"aaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0253dd39-f4f9-4510-934f-ae11a748df7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEAAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEAAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

