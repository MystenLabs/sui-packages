module 0x4b8147d9df76d081205c4c3d7771401e03cf4123ac29534f6dccb681f695baed::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 9, b"SEAL", b"Secure Encrypted Access Layer", x"e2809c50726f7465637420746865207365637265742e205368617265206f6e6c7920776861742773206e65656465642ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sdmntpreastus.oaiusercontent.com/files/00000000-a628-61f9-81f4-3400bd17f307/raw?se=2025-07-22T17%3A51%3A56Z&sp=r&sv=2024-08-04&sr=b&scid=16bdbb4c-d929-5eff-ad6f-bc2cd16ec28e&skoid=f28c0102-4d9d-4950-baf0-4a8e5f6cf9d4&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-07-21T22%3A42%3A39Z&ske=2025-07-22T22%3A42%3A39Z&sks=b&skv=2024-08-04&sig=VWSurURfsTB/obAJtYUqw/dbJe0nOXcVWDEM9qCMerg%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEAL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

