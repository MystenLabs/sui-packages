module 0xba90688e88138295fe663f0a9e435aea9f45e06599e02af361a88f2366447aa0::suiking {
    struct SUIKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKING>(arg0, 6, b"SUIKING", b"sui king", b"We are thrilled to announce the Suiking  Launch, where everyone has a chance to be part of the Suiking revolution! This is your opportunity to invest in a project designed to disrupt the crypto space and bring fun and excitement to the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiki_233454a990.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

