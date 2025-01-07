module 0xc80f56c5830a6439c09024b048052385a72947d18096432b8adc4f49552ba41f::hts {
    struct HTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTS>(arg0, 9, b"HTS", b"Hot Girs", b"Hot girs token meme wave ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b43aa1b-c81b-4ba6-afd6-feeaa97f6040.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

