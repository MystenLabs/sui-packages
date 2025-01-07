module 0xb842ff6d347b7bfed9be35f0c2a22eb34dc7e099a83d55fd9075b55b8cfdb4c6::peepe {
    struct PEEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPE>(arg0, 6, b"PEEPE", b"Peepe on Sui", b"Peepe isnt just another meme coin. Its Pepe with a twist  straight outta the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5bc8d1bc_46ad_4d13_8a90_7596af03b0cd_cc91016c44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

