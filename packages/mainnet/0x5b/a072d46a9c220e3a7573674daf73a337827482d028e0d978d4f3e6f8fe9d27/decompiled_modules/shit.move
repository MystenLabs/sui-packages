module 0x5ba072d46a9c220e3a7573674daf73a337827482d028e0d978d4f3e6f8fe9d27::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 9, b"SHIT", b"SHITCOIN", b"First SUI shitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdee4ac7-a91a-4a35-b1f8-be472fa9f155.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

