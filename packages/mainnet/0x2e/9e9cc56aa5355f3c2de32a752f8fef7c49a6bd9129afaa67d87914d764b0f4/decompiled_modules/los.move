module 0x2e9e9cc56aa5355f3c2de32a752f8fef7c49a6bd9129afaa67d87914d764b0f4::los {
    struct LOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOS>(arg0, 6, b"LOS", b"Liquor On Sui", b"Be liquor, my friend. New era of meme on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/liquer_6065d90547.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

