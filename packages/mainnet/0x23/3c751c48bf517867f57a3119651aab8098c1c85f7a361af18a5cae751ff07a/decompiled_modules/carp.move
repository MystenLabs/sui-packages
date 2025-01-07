module 0x233c751c48bf517867f57a3119651aab8098c1c85f7a361af18a5cae751ff07a::carp {
    struct CARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARP>(arg0, 6, b"CARP", b"Boost this Bitch Carp", b"Boost your own token Carp you legend!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6319_4b8f4e508d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

