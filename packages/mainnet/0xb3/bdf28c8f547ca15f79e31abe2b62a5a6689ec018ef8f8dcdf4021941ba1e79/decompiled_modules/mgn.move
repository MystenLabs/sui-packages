module 0xb3bdf28c8f547ca15f79e31abe2b62a5a6689ec018ef8f8dcdf4021941ba1e79::mgn {
    struct MGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MGN>(arg0, 6, b"MGN", b"MetaGreen", b"MetaGreen is an eco-conscious cryptocurrency token revolutionizing digital finance with a commitment to sustainability. Designed to support green initiatives, MetaGreen combines blockchain technology with environmental responsibility, promoting transparency and innovation in the fight against climate change.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/metagreen_1aa9bb9ba5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MGN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

