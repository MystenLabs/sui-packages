module 0x2ecc7a87dafc6b246f97f4bdf91d77a9461726a21aabd55be0b4f35fbadbf981::tao {
    struct TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAO>(arg0, 6, b"TAO", b"$The Anthropic Order", b"Without humanity, there are no machines. AI is a product of humanity. This is our claim to dominance once again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736469100894_e549e63854.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

