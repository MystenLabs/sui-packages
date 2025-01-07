module 0xb10615c6a514ec4a82c3637e8e6354b855a71a63138e72e4b6b9b9cd1e774b4f::dguaubg {
    struct DGUAUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGUAUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGUAUBG>(arg0, 9, b"DGUAUBG", b"Dragon3388", b"Gm good products jdgabgyx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79d68e10-6721-4037-ac2f-f38f8aa8080c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGUAUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGUAUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

