module 0xeb4047c6bcd1a2702ac9585aae99d641d50b324ee065de5d0c47411f533871a8::suisaurus {
    struct SUISAURUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAURUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAURUS>(arg0, 7, b"SUISAURUS", b"SUISAURUS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-M6J91bCHBgXXUfY2a6b6q1Fn?se=2024-01-09T15%3A11%3A55Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3Df749a701-6de9-427e-b126-1a5ed43b3e74.webp&sig=ZArmrTwzQVAoEn0rCNMoBYxPXVxQYEV8V6NavREMM1w%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISAURUS>(&mut v2, 777777777770000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAURUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAURUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

