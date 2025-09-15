module 0x1ec0f6b1477daf7f4b32e81ba506bf5e7b4763d666c77eac7b45ed40d0358eaf::People {
    struct PEOPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOPLE>(arg0, 9, b"PEEPS", b"People", b"people r here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G07LjugWkAAt8Jc?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEOPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOPLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

