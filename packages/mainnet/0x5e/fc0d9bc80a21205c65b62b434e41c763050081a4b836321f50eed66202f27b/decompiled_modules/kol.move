module 0x5efc0d9bc80a21205c65b62b434e41c763050081a4b836321f50eed66202f27b::kol {
    struct KOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOL>(arg0, 9, b"KOL", b"Kol", b"Sayuran sehat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06a8bd22-af34-4ab9-bdee-164848ee59f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

