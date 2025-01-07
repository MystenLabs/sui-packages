module 0xeb57a3c31006bde17614952ef5f018ab4242d46ba4beea6e65f665cec2df4ac3::hfd {
    struct HFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFD>(arg0, 9, b"HFD", b"F", b"FDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/242e1695-09d2-4591-a1cd-ae8a6729c8fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

