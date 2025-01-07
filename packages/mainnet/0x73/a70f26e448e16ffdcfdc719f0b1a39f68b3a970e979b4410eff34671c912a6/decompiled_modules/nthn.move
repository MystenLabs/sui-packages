module 0x73a70f26e448e16ffdcfdc719f0b1a39f68b3a970e979b4410eff34671c912a6::nthn {
    struct NTHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTHN>(arg0, 6, b"NTHN", b"Nothing!", b"No information, no community on X, Telegram, or anywhere else,  this is different from regular tokens. It's just a collection in your wallet. Don't trust it!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086763_be98c07128.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

