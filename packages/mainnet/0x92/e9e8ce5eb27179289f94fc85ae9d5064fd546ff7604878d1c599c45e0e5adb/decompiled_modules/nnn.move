module 0x92e9e8ce5eb27179289f94fc85ae9d5064fd546ff7604878d1c599c45e0e5adb::nnn {
    struct NNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNN>(arg0, 9, b"NNN", b"NO NUT NOVEMBER", b"NO NUT NOVEMBER BEGINS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.scdn.co/image/ab67616d0000b2736975c8220c0f9bc8ebb2ce51")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NNN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

