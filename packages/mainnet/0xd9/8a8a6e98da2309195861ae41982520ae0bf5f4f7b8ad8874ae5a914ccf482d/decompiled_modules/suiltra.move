module 0xd98a8a6e98da2309195861ae41982520ae0bf5f4f7b8ad8874ae5a914ccf482d::suiltra {
    struct SUILTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILTRA>(arg0, 6, b"SUILTRA", b"SUILTRAMAN", b"SUILTRAMAN, the blue hero who can control water, is always ready to save the world while making sure all his enemies are soaked. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ultraman_light_blue_f4dc2874d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILTRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILTRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

