module 0x7c7f07cd3a300a26c76d3b3a5880b6325dd922b489c21b94b3f55f55725e3595::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 6, b"Su", b"Sunbrick", b"A presence as intense as the blazing sun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d11c7c04_472d_4582_b393_9431197c7216_ed39450f85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SU>>(v1);
    }

    // decompiled from Move bytecode v6
}

