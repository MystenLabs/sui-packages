module 0xe31ef7665b8f1a633d14e22bfb6caed31f84e45152e23f0e32f0aa67d0c07b45::bobesui {
    struct BOBESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBESUI>(arg0, 6, b"BOBESUI", b"BOBE", b"Dogs are crazy and we always take care of them until they grow up $BOBE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039417_261700dbd9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

