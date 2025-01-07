module 0xd0da4c6d8ee5fff7c0ce242d653eb6b460d94964a8cc3a54ad8db7ea571cad0::poowel {
    struct POOWEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOWEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOWEL>(arg0, 6, b"POOWEL", b"JORAM POOWEL", b"Study Conviction. The Poowel Chads Go Brrr | $POOWEL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z2_Luc_Ip_400x400_623c194be8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOWEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOWEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

