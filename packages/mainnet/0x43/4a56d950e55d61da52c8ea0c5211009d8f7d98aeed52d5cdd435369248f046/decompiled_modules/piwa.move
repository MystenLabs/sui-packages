module 0x434a56d950e55d61da52c8ea0c5211009d8f7d98aeed52d5cdd435369248f046::piwa {
    struct PIWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIWA>(arg0, 6, b"PIWA", b"Piwa Sui", b"piwa spreads joy in memes while searching for the most exciting opportunities in the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012459_e9f1989d7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

