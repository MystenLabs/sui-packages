module 0x9d6862385231f1f38383b8c91ffb83c2a8f7ba05e771f689ebcba282840da649::fishnchips {
    struct FISHNCHIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHNCHIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHNCHIPS>(arg0, 6, b"Fishnchips", b"Fish & chips", b"Have some fish and chips on liquid blockchain. Fully decentralized. No twitter no telegram no team. Buy and enjoy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028285_0250811019.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHNCHIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHNCHIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

