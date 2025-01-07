module 0xa28516ad571ca67a35e3d5688053a1248ab5363dd9dbbb2480b16432c736e400::terrio {
    struct TERRIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRIO>(arg0, 6, b"Terrio", b"First Nigga on Sui", b"First nigga on sui, i will be the sui mascot, I will takeover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/terio_umm_dbe0bd426a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERRIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

