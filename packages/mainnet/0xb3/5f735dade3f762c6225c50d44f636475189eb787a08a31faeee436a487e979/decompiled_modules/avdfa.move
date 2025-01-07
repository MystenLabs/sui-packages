module 0xb35f735dade3f762c6225c50d44f636475189eb787a08a31faeee436a487e979::avdfa {
    struct AVDFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVDFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVDFA>(arg0, 9, b"avdfa", b"asvc", b"3rwfsdsdcz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AVDFA>(&mut v2, 1213000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVDFA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVDFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

