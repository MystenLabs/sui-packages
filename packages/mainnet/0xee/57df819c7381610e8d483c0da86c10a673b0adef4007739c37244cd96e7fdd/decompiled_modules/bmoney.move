module 0xee57df819c7381610e8d483c0da86c10a673b0adef4007739c37244cd96e7fdd::bmoney {
    struct BMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMONEY>(arg0, 6, b"BMONEY", b"Brett MONEY by matt furrie's", x"42204d6f6e657920697320616e20616c7465726e61746520706572736f6e61206f662042726574742c206f6e65206f66207468652063656e7472616c206368617261637465727320696e204d617474204675726965732022426f797320436c756222207365726965730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5c4dca5bbac09387995f4f3efdfb77fe_c63015db09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

