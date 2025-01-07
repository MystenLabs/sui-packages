module 0x18226ed875b13d27b435c5042d80a31bbc10052133821333de8d017eeb32c1f5::power {
    struct POWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWER>(arg0, 9, b"POWER", b"POSSUMS ", b"POSSUMS is a meme inspired by the spirit of adventure and freedom with possums, we are not just riding the waves we are mastering thems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1b40e99-2efe-4b87-b9f5-650faf4a9d77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

