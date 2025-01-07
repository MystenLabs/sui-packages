module 0xb79a8b51755cae5e460749b4c791eea627006e39a5b92bec8a8a9bddb93b6577::dmb {
    struct DMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMB>(arg0, 6, b"DMB", b"DUMBO", b"Baby cute on ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199153_8db11aaa3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

