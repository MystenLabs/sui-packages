module 0x2389849bc8f5d65a999cf79c83ed4297c35c4c276fbb88d5a007171772acda42::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"sad dog", b"sad dog needs a new owner, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002736891_3ca4bbd9b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

