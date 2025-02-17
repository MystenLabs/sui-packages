module 0xd974af5505219280b0e2cbb6bdbbe89ad8cd5f24dd2e0a94d36bd73d992f13d8::khanhwitness {
    struct KHANHWITNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHANHWITNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHANHWITNESS>(arg0, 9, b"khhymbok", b"khanhname", b"khanhdes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"khanhicon")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KHANHWITNESS>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHANHWITNESS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KHANHWITNESS>>(v2);
    }

    // decompiled from Move bytecode v6
}

