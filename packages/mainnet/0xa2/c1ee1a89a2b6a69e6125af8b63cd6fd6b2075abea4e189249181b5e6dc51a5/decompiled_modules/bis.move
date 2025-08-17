module 0xa2c1ee1a89a2b6a69e6125af8b63cd6fd6b2075abea4e189249181b5e6dc51a5::bis {
    struct BIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIS>(arg0, 9, b"BIS", b"BLAST_IS_ASS", b"blast is not good sorry...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIS>>(v2, @0x341e34c6e78efa411d91c73809eb5bee7669f5c9da0421de6dc21857f8b68f57);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

