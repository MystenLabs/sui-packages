module 0x84cb577032f81f9116570ecdf23eec1288113f1f6482d0adabbc862fcf576b0a::mytkn {
    struct MYTKN has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: MYTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYTKN>(arg0, 9, b"MYTKN", b"My Token", x"e6b58be8af95e4bba3e5b881206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiagnvvdmqiycz3qkfcvjfbsb3bhkkpvlkimb3tl25v6y3n7gxmzey")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYTKN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYTKN>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<MYTKN>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<MYTKN>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

