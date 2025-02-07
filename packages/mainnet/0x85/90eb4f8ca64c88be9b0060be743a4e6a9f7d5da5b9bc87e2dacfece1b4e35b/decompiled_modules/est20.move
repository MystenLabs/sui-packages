module 0x8590eb4f8ca64c88be9b0060be743a4e6a9f7d5da5b9bc87e2dacfece1b4e35b::est20 {
    struct EST20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST20>(arg0, 6, b"EST20", b"testing", b"sdfasd asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738927647313-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST20>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

