module 0x1b354ac234d8bb177b0fceecae3081671b9c59bde9e55587ab4d00ef4fe54c2e::lucent {
    struct LUCENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCENT>(arg0, 9, b"LUCENT", b"Lucent", b"throne and liberty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUCENT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCENT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

