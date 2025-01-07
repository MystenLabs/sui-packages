module 0xec826faabe0485f5f8982355a710348c82989a5cecb22694fc14b70c66b43e55::xox {
    struct XOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XOX>(arg0, 6, b"XoX", b"EmojiXoX", b"Coming soon with the Sui 404 standard and $XOX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_6a87638735.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

