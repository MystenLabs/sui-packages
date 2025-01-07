module 0xc4bd327eead6b0cd2d3743c38daaa7adfe271c903e6470221956bce9d674a1d8::carl {
    struct CARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARL>(arg0, 6, b"CARL", b"Cats are liquid", b"A better place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979323007.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

