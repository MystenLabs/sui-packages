module 0x505f73f75f5f869ba994148d28cdf85d36a03b0e426b7d405ed139d88ff22afd::gwib {
    struct GWIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWIB>(arg0, 6, b"GWIB", b"GWIB on Sui", x"4757494273206e61727261746976652069732073696d706c653a204765742057696e7320496e2042756c6c72756e206f6e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a65e15_5d132f5efcd74c6ba905b34479dd6f99_7_Emv2_73818f86fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

