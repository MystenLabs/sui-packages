module 0x6ddfb0a15a76900d67f8fbc828375108278d1de97e56037db43180868c01ac6a::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SW>(arg0, 6, b"SW", b"SuperWeed", b"Weed That's takes you past Uranus ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_423178362490710_894df0debb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SW>>(v1);
    }

    // decompiled from Move bytecode v6
}

