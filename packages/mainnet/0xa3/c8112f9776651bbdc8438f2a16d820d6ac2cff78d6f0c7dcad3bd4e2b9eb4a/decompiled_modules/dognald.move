module 0xa3c8112f9776651bbdc8438f2a16d820d6ac2cff78d6f0c7dcad3bd4e2b9eb4a::dognald {
    struct DOGNALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNALD>(arg0, 6, b"DOGNALD", b"Dognald Trump On Sui", b"Dognald Trump is a dog like no other. Not only does he possess Trumps leadership skills, but he also carries the loyalty and charm of a dog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1024x1024_2d4bb4832c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

