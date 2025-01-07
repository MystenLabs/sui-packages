module 0xc41391386420a929e413355158343a497334f01b5e6af1a083208ae37231ee0b::bmove {
    struct BMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOVE>(arg0, 6, b"BMove", b"BlueMove", b"The leading Multi-chain NFT Marketplace on Aptos and Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1111png_1f8d55bcc3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

