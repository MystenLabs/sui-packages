module 0x86f82f6c4f2520f2830897dd903a8d9c7d267232d304cf6a1c15a484e51873ce::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 6, b"WAL", b"Walrus Protocol", b"Walrus is a decentralized storage network that stores and delivers raw data and media files like videos, images, and PDFs without sacrificing performance or accessibility. With Walrus, your data is always secure and available.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WAL_096bb666ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

