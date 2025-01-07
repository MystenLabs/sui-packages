module 0x2542054ce1858489f5b68da4e78bcc71aeaef25f5106f55df4cb97c991ce455b::creator {
    struct CREATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATOR>(arg0, 6, b"CREATOR", b"Creator", b"I'm the true Move Creator. Don't let @b1ackd0g fool you; he just fetches the code.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/creator_e14d2e8beb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

