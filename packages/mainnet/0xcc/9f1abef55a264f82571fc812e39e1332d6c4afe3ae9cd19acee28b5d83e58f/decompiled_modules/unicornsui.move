module 0xcc9f1abef55a264f82571fc812e39e1332d6c4afe3ae9cd19acee28b5d83e58f::unicornsui {
    struct UNICORNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICORNSUI>(arg0, 6, b"Unicornsui", b"Unicorn", b"Fly with unicorn sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000908090_c20d7a7e4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICORNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

