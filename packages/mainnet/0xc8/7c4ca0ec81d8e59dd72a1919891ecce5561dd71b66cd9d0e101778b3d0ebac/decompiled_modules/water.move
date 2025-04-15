module 0xc87c4ca0ec81d8e59dd72a1919891ecce5561dd71b66cd9d0e101778b3d0ebac::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"Sui Water", b"sui water is the latest breakthrough in the sui network, a great meme that has the essence of the power of water itself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058318_ef12c8fd84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

