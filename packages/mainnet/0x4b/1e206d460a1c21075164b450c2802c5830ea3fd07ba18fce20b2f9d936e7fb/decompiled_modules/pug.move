module 0x4b1e206d460a1c21075164b450c2802c5830ea3fd07ba18fce20b2f9d936e7fb::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"pug wif tie", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://koi.family/api/images/278ccf7f18cab13ccc6d4fe79bbd8b9de104d64136af26e1785324bfdf4e3e00.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUG>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

