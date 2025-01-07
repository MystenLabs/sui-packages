module 0x4fd12f4823cec79bcc5cd837b61a0c6d63c59500b10fa645461c3ef57d975c12::shi {
    struct SHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHI>(arg0, 6, b"SHI", b"Ryoshi Research", b"\"Decentralization, it works\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_11_19_03_11_22_38d17485f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

