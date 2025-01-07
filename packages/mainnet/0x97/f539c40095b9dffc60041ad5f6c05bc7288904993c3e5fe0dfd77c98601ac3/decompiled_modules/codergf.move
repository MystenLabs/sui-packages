module 0x97f539c40095b9dffc60041ad5f6c05bc7288904993c3e5fe0dfd77c98601ac3::codergf {
    struct CODERGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODERGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODERGF>(arg0, 6, b"CoderGF", b"Coder GF", b"Your friendly AI companion who also happens to be a world-class coder  Come in for a chat. Or to create full-featured apps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_c655409026.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODERGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODERGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

