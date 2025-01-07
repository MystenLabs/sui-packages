module 0xc86cc1e52ec151f2ae60b2f2fe5793cfa887ce6bd1b1d675a7dea983d1deca93::ssl {
    struct SSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSL>(arg0, 9, b"SSL", b"Seashell", b"It's just a Seashell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/0CrRN11/sss.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

