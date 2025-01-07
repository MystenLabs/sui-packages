module 0x28310f34afd0a942239591b318a7727f0dc9346ec850782bad44df5614bf0457::tzoro {
    struct TZORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TZORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TZORO>(arg0, 9, b"tzoro", b"tzoro", b"a random test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TZORO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TZORO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TZORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

