module 0x1fbe01430aec4b243e305be6975a16ffa7bebe9d98b11e7fee455a0b173d2274::paco {
    struct PACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACO>(arg0, 6, b"PACO", b"SUI PACO", x"5061636f207761732050657065206265737420667269656e642c2062757420506570652073746f6c6520686973206769726c667269656e6420736f205061636f20626563616d6520666174206e206465707265737365642e2e2e204a6f696e2068697320636f6d656261636b20616e6420726576656e676520706c616e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PACO_Logo_5d35b885a9_c3bc1e8e94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

