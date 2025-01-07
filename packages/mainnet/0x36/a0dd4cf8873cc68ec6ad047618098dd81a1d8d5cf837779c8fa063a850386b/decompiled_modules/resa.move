module 0x36a0dd4cf8873cc68ec6ad047618098dd81a1d8d5cf837779c8fa063a850386b::resa {
    struct RESA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESA>(arg0, 9, b"RESA", b"RealSatosh", b"On this photo real Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a2df739-b938-4b0f-94fc-dc956abf320a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESA>>(v1);
    }

    // decompiled from Move bytecode v6
}

