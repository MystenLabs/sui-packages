module 0x673b349354d4e253fa5833197c8f40540855e9f5a6bf5d3385c3d1932ede60f5::liquor {
    struct LIQUOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUOR>(arg0, 6, b"LIQUOR", b"Liquor", b"Be liquor, my friend. New era of meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060076_b537bca0d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQUOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQUOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

