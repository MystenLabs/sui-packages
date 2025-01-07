module 0xca58183df09e7b5fb7756cfb80991183ca063c18c37e8ccc79ac7da234fe4673::kol9 {
    struct KOL9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOL9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOL9>(arg0, 9, b"KOL9", b"KOLJO9", b"KKOJIU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc124c2f-230f-4328-bfd1-220efd49805b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOL9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOL9>>(v1);
    }

    // decompiled from Move bytecode v6
}

