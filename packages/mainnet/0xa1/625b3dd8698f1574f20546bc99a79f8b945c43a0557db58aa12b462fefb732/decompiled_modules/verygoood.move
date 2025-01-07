module 0xa1625b3dd8698f1574f20546bc99a79f8b945c43a0557db58aa12b462fefb732::verygoood {
    struct VERYGOOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERYGOOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERYGOOOD>(arg0, 9, b"VERYGOOOD", b"Gisui", b"Suispeed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a126a5a3-ccae-486c-8751-ee10d263c41b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERYGOOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VERYGOOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

