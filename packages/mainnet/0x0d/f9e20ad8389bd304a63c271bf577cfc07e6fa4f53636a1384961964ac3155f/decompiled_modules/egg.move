module 0xdf9e20ad8389bd304a63c271bf577cfc07e6fa4f53636a1384961964ac3155f::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"Just egg", b"JUST EGG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028984_9c947d08f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

