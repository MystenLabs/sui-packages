module 0x16d02c051fcecaaf7bd9814409ac55799a9f5fe0631de0e4533e6f811289b503::pshark {
    struct PSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSHARK>(arg0, 6, b"PSHARK", b"PopShark", b"Sharks now poppin' in the SUI Oceans with their shiver called $PSHARK. They are known as cute, sweet creatures with great ability in any given activity. The only difference is that - they keep their mouth open all the time, but don't worry, $PSHARKs won't bite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_39_53_ff24d7b037.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

