module 0xee14c0e5403bbf517b1d5c5717fbe6e827faf1a06d34022e4b68b5b045a458e6::shuiman {
    struct SHUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIMAN>(arg0, 6, b"SHUIMAN", b"SHUI MAN", b"The Shui Man enter the world and fight for nice and fresh Water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028293_d5b5c651b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

