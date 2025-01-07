module 0xa41874fefa84f1928b96b23ed7754a486c0ef3f5c3e469c0e7cb67be85aefbfa::people {
    struct PEOPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOPLE>(arg0, 6, b"PEOPLE", b"Sui People AI", b"Revolutionize the intersection of artificial intelligence and human interactions. for the #PEOPLE by the $PEOPLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036646_4dd688cf1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

