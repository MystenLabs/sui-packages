module 0x2a03485d0604320d484c663d535fb0e06fbcd82d2c62e6d12ef9640aa726b79e::ok {
    struct OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OK>(arg0, 6, b"OK", b"OKBET", b"ok bet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibvv4huppaniobqswfnrhwjgaakizspv7eqi4qsknxbqipm27sjoe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

