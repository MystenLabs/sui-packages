module 0x26d59a57e99536c2337c46fa9cb7e6696400d57de93eee197e87ea7181a48a84::sasha {
    struct SASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHA>(arg0, 6, b"SASHA", b"SASHA - Bitcoin Cat", b"Sasha - is the first Bitcoin Cat, posted by Len Sassaman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/255125568_236d9610e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

