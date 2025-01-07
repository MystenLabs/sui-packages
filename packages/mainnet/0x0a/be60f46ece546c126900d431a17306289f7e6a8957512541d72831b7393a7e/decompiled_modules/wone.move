module 0xabe60f46ece546c126900d431a17306289f7e6a8957512541d72831b7393a7e::wone {
    struct WONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONE>(arg0, 9, b"WONE", b"jdnd", b"hdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23012694-e68b-4623-bbc1-3421bf517d5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

