module 0xf7ba60c493c02736b80b0d7ff82229e983fdbda33a15a3edd6a64160e30a88bc::apes {
    struct APES has drop {
        dummy_field: bool,
    }

    fun init(arg0: APES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APES>(arg0, 6, b"APES", b"Three APES Sui", b"Born from passion and driven by results, We're grown from a humble ape tribe to a leading digital powerhouse of apes!. Website: https://threeapesui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/512_a0eb8f4dfe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APES>>(v1);
    }

    // decompiled from Move bytecode v6
}

