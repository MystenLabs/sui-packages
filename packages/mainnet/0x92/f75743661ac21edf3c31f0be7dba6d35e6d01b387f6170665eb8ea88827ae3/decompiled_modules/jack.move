module 0x92f75743661ac21edf3c31f0be7dba6d35e6d01b387f6170665eb8ea88827ae3::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK>(arg0, 6, b"JACK", b"Jack The Crab", b"$JACK is the only blue crab on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Profile_Photo_9ea5a1a18d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

