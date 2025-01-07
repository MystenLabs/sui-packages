module 0xd3105b58100bc60bf4071ead17d9015658de37b0397b9e7f3c49a88b709c1123::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"Artificial Idiot", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/5cf715ef-24ea-4d60-9c7e-d3550872c29f/dcmbd8-bed1ebca-9624-4865-b721-011eca24363e.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzVjZjcxNWVmLTI0ZWEtNGQ2MC05YzdlLWQzNTUwODcyYzI5ZlwvZGNtYmQ4LWJlZDFlYmNhLTk2MjQtNDg2NS1iNzIxLTAxMWVjYTI0MzYzZS5wbmcifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.qT2HEM2gV-IpAW9xENbCGiSvnQOGa3Yg3HYHsLEE6ps")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AI>(&mut v2, 10111010101000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

