module 0x802a1db83af449ff4ac07bad21e15c40b58b63f65b009bb03fd3f84e7181afb8::donki {
    struct DONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKI>(arg0, 6, b"DONKI", b"DONKI on SUI", b"DONKI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/donki_8166a3d6fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

