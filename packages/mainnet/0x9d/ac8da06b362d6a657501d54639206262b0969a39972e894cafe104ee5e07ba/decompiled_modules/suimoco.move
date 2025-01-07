module 0x9dac8da06b362d6a657501d54639206262b0969a39972e894cafe104ee5e07ba::suimoco {
    struct SUIMOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOCO>(arg0, 6, b"SUIMOCO", b"MOCO", b"SUIMOCO is a Puppy who was looking for new adventures on the blockchain. As he loves cryptography, he was searching for a network to call home, and thats when he found Sui and fell in love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000366_370db3ada1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

