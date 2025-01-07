module 0x8330bca9df39e5e7c34e3f70ecaed7968e9f7216218e7682d187c30debe11936::foster {
    struct FOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOSTER>(arg0, 6, b"FOSTER", b"Foster coin", b"$Foster thought in his head for a success and the most successful memento ever in sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056754_aa685f085d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

