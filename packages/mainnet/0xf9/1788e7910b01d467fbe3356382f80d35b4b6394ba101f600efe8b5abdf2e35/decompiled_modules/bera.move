module 0xf91788e7910b01d467fbe3356382f80d35b4b6394ba101f600efe8b5abdf2e35::bera {
    struct BERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERA>(arg0, 6, b"BERA", b"BERA ON SUI", x"42455241205355490a20436f6d6d756e69747920697320686f6d652c2077686572652077652062656c6f6e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_7_2930d424f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

