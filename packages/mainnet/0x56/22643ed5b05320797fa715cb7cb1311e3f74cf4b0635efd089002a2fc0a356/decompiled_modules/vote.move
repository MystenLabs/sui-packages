module 0x5622643ed5b05320797fa715cb7cb1311e3f74cf4b0635efd089002a2fc0a356::vote {
    struct VOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOTE>(arg0, 6, b"VOTE", b"Vote Trump to save the world!", x"57454c434f4d4520544f20564f5445205452554d5020556e61706f6c6f6765746963616c6c79206368656572696e6720666f72205472756d70203230323421204e6f7420616666696c69617465642c206a75737420612066616e206f6620776f726c64207065616365210a466f6c6c6f7720666f72206120666f6c6c6f77206261636b2120504c4541534520564f544520464f5220505245534944454e54", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1915_5520aaa9a2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

