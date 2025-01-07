module 0x9b67363bb3322f30736c034d71e74c88c59c9961b77aaaaa9b1b7edb9eb921a9::tnd {
    struct TND has drop {
        dummy_field: bool,
    }

    fun init(arg0: TND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TND>(arg0, 6, b"TND", b"tendies", x"495427532054494d4520544f204c4556455241474520594f555220484f5553450a4c455453204745542054484553452054454e44494553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hqdefault_392f34b0bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TND>>(v1);
    }

    // decompiled from Move bytecode v6
}

