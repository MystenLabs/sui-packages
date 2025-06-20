module 0x7f2c5e548bcfed0505abfec0c41422014479bff247a5b736f373fd601d2bd312::cd {
    struct CD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CD>(arg0, 6, b"CD", b"CatD", b"Cs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreianiqo4fm6ugdnf2z6pizpxkjgfitpuvqp6wx4bln43t6njabxe6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

