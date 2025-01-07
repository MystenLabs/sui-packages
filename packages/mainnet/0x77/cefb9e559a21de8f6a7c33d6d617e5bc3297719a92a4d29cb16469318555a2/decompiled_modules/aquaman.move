module 0x77cefb9e559a21de8f6a7c33d6d617e5bc3297719a92a4d29cb16469318555a2::aquaman {
    struct AQUAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAMAN>(arg0, 6, b"AQUAMAN", b"AQUA", b"The Defendr Of The Sui Meme Universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x7a1495d9b7debde00cb5b1d0b2d5484234d93e04a5290524274be11842825b99_aqua_aqua_b10cbd1763.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

