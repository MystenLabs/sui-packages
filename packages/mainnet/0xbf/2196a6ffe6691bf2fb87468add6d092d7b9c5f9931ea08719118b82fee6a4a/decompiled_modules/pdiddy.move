module 0xbf2196a6ffe6691bf2fb87468add6d092d7b9c5f9931ea08719118b82fee6a4a::pdiddy {
    struct PDIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDIDDY>(arg0, 9, b"PDIDDY", b"PUFF", b"DID HE DO IT???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PDIDDY>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDIDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

