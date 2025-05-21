module 0x16a8cde71dabea09c776fca53c5eb5b1568b6a50f0f9f817f6cd7bf1bfbd6bea::unagi {
    struct UNAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNAGI>(arg0, 6, b"UNAGI", b"Unagi", x"e2809c556e6167692069732061207374617465206f6620746f74616c20636861696e2061776172656e6573732e204f6e6c7920627920616368696576696e67207472756520556e6167692063616e2061207072652d7269636820646567656e207374617920726561647920666f7220616e79207275672c2064756d702c206f72207768616c652061747461636b2074686174206d617920636f6d65207468656972207761792ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747785517499.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNAGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNAGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

