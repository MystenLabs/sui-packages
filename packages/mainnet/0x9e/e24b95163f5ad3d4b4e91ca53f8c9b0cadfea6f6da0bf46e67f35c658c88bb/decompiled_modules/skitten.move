module 0x9ee24b95163f5ad3d4b4e91ca53f8c9b0cadfea6f6da0bf46e67f35c658c88bb::skitten {
    struct SKITTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITTEN>(arg0, 6, b"SKITTEN", b"The Skitten", b"The arrival of $SKITTEN brings peace and help to the kitten world  because its all about kittens and will always be.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250502_234002_4ac26f0cb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITTEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITTEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

