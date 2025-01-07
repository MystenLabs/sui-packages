module 0xb0819a488a709a0a3bbf16d249d2497d11170b05f8449bd1501fc1207b53751c::suistone {
    struct SUISTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTONE>(arg0, 6, b"Suistone", b"Sui stone", b"Sui stone can list dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20240927_234615964_12ea5cd2a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

