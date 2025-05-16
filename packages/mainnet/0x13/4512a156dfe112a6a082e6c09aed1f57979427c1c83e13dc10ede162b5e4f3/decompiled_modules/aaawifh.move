module 0x134512a156dfe112a6a082e6c09aed1f57979427c1c83e13dc10ede162b5e4f3::aaawifh {
    struct AAAWIFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAWIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAWIFH>(arg0, 6, b"AAAWIFH", b"AAAWIFHAT", x"23414141574946484154205448450a4355544520434154574946484154204f4e2023535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifqryeeyl4ihjztkpslybkdafni6xqtewfms2jnoznbisemacq4bq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAWIFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAAWIFH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

