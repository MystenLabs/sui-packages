module 0x45183dc0277b71edea9d215adc540e06cfe0f8318957977be2df515ea469f486::norug {
    struct NORUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORUG>(arg0, 8, b"NoRug", b"NeverRug", b"\"NeverRug is a cryptocurrency that guarantees it will never perform a rug pull. The liquidity is permanently locked, ensuring trust and security for all holders.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-hzfqeGybXliXhQUvbl56M6DZ?se=2024-09-27T09%3A48%3A14Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D604800%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D568d12aa-7745-4305-843a-1826ce2d4548.webp&sig=whr8PAEIPcACkQeuorR8X7EfMHH7CI33PE0eMxXQKOw%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NORUG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

