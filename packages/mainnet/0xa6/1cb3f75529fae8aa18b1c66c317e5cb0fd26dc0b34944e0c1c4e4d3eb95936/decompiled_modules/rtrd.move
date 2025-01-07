module 0xa61cb3f75529fae8aa18b1c66c317e5cb0fd26dc0b34944e0c1c4e4d3eb95936::rtrd {
    struct RTRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTRD>(arg0, 6, b"RTRD", b"Retardeng", b"bringing in the Solana narrative of the retardios and the animal narrative (moo deng) to the $SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6512_eb2841b2b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

