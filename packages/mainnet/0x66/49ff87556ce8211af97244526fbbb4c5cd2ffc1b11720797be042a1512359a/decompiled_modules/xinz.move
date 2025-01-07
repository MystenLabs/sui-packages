module 0x6649ff87556ce8211af97244526fbbb4c5cd2ffc1b11720797be042a1512359a::xinz {
    struct XINZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: XINZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XINZ>(arg0, 9, b"XINZ", b"ZINX", b"JINZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cd4e86b-ad7a-4935-b7c2-b0dcb48e1f64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XINZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XINZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

