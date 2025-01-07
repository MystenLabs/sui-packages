module 0x19a4bd291b64d0a604db0dc7c82780e16e007d57794cf7eef782c65b1ac67322::ntb {
    struct NTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTB>(arg0, 9, b"NTB", b"NauticalBit", b"TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrT0PNwL8YCFB1BsKGdufSYi7cCFzXJkvtQw&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NTB>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

