module 0xb1750eb67511168a7b10727d7e38bc8519e82446476a5447adf84889e0bf85a9::zmn {
    struct ZMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZMN>(arg0, 6, b"ZMN", b"Zaman Baba", b"TIME DADY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a3ffd124_4177_415b_b552_45d0138ee5fa_255bdb133f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

