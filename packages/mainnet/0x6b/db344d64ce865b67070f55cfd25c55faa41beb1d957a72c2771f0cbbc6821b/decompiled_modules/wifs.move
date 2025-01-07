module 0x6bdb344d64ce865b67070f55cfd25c55faa41beb1d957a72c2771f0cbbc6821b::wifs {
    struct WIFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFS>(arg0, 6, b"WIFS", b"dogwifhat on sui", b"Popular meme Dogwifhat vibes on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_11_20_11_44_48_8ada4b4faa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

