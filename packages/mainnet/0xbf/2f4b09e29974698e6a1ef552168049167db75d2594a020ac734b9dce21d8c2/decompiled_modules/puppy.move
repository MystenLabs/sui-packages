module 0xbf2f4b09e29974698e6a1ef552168049167db75d2594a020ac734b9dce21d8c2::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPY>(arg0, 6, b"PUPPY", b"PUPPYSUI", x"74686520646f67206f662073756920636f2d666f756e6465722c206576616e206368656e670a5055505059535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197082_816946e717.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

