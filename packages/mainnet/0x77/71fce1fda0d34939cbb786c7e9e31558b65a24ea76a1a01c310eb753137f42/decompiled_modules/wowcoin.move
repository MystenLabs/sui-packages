module 0x7771fce1fda0d34939cbb786c7e9e31558b65a24ea76a1a01c310eb753137f42::wowcoin {
    struct WOWCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWCOIN>(arg0, 9, b"WOWCOIN", b"WOWMEME ", b"Created from the inspiration of the cat's wow effect ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efa9b5d2-8989-4ae8-bf1f-1993a9280cc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

