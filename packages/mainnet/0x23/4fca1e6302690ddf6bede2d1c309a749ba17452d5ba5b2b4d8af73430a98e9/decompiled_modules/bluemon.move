module 0x234fca1e6302690ddf6bede2d1c309a749ba17452d5ba5b2b4d8af73430a98e9::bluemon {
    struct BLUEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEMON>(arg0, 6, b"BLUEMON", b"Blue Pokemon Sui", b"BlueMOn  is not just a meme but a companion, a symbol of change and new creativity. With BlueMOn, every limit can be overcome, every dream can come true.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig6q7r3fepg7hllnyvjapm4tsf2jfqfnrlxwdqr2wnupufixrfree")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

