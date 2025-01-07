module 0x8543560583b884948465e90688fd6e071bcb26d02b8498a83a0c6ea757a1e10a::scn {
    struct SCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCN>(arg0, 6, b"SCN", b"Suicune", b"Embody the power of the legendary Suicune with a meme coin built for the future. Swift, majestic, and ready to make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa58e30c_9b00_4e6f_a554_cca84f815f62_80e8c92e59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

