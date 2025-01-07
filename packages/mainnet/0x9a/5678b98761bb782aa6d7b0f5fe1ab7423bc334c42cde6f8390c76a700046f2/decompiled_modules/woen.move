module 0x9a5678b98761bb782aa6d7b0f5fe1ab7423bc334c42cde6f8390c76a700046f2::woen {
    struct WOEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOEN>(arg0, 9, b"WOEN", b"jene", b"djnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/220ccc2c-d4e4-46f3-891c-3de759f0b998.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

