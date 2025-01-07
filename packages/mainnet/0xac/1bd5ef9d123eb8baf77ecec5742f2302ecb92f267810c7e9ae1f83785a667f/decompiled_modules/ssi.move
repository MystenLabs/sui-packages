module 0xac1bd5ef9d123eb8baf77ecec5742f2302ecb92f267810c7e9ae1f83785a667f::ssi {
    struct SSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSI>(arg0, 6, b"SSI", b"SUNSUI", b"$SSI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nong_nao_541acf1804.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

