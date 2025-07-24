module 0x5a7b0c6803411cc59718e802adee6be6b53ae2777b416135372154333a9f5410::b_r00ter {
    struct B_R00TER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_R00TER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_R00TER>(arg0, 9, b"bR00TER", b"bToken R00TER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_R00TER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_R00TER>>(v1);
    }

    // decompiled from Move bytecode v6
}

