module 0xfac46a1508f223ebfa9af6fb304b6994248fbe3f9e1538cf29bdddc7a25f1973::im {
    struct IM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IM>(arg0, 6, b"IM", b"IndianMusk", x"4f6e6c79206f6e205375692e200a0a496e64756c676520696e2074686520457373656e6365206f6620496e6469612e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/musk4_b2b5ece7e7.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IM>>(v1);
    }

    // decompiled from Move bytecode v6
}

