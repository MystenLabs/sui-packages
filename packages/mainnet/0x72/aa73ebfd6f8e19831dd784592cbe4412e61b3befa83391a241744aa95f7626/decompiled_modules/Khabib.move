module 0x72aa73ebfd6f8e19831dd784592cbe4412e61b3befa83391a241744aa95f7626::Khabib {
    struct KHABIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHABIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHABIB>(arg0, 9, b"KHABIB", b"Khabib", b"tatoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gzw6N-0a4AAsbRB?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHABIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHABIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

