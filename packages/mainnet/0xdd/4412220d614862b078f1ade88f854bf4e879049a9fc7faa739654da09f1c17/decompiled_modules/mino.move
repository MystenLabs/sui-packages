module 0xdd4412220d614862b078f1ade88f854bf4e879049a9fc7faa739654da09f1c17::mino {
    struct MINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINO>(arg0, 6, b"MINO", b"Mino Shiba", b"There were three main lines of the Shiba that have been combined to form todays breed. These were the Mino Shiba, known for its fiery red color, the Sanin Shiba, which is larger boned and slow to mature, and the Shinshu Shiba, which had a very thick bristly outer coat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd780934d1d974b52c2ae86a4f467e0d9a1672fc8_6bb6053c9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

