module 0xb7f6d05150b75d757a0e2e1c69cff60f15cf5c9b046dcbba43e3dd48e035e742::est15 {
    struct EST15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST15>(arg0, 6, b"EST15", b"testing", b"sdfasd asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738921022730-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST15>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

