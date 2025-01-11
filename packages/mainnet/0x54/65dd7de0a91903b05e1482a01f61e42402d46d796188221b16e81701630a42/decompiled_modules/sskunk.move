module 0x5465dd7de0a91903b05e1482a01f61e42402d46d796188221b16e81701630a42::sskunk {
    struct SSKUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSKUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSKUNK>(arg0, 6, b"SSKUNK", b"The Sneaky Skunk", b"The sneakiest meme skunk in the sui blockchain. Bringing laughs and mischief to your feed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023396_12aab80c6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSKUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSKUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

