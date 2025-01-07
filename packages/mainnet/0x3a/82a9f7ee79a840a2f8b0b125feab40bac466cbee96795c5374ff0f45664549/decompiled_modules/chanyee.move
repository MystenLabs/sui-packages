module 0x3a82a9f7ee79a840a2f8b0b125feab40bac466cbee96795c5374ff0f45664549::chanyee {
    struct CHANYEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHANYEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANYEE>(arg0, 6, b"ChanYee", b"ChanYee Coin", b"ChanYee Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9207_2_799e9ad266.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANYEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHANYEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

