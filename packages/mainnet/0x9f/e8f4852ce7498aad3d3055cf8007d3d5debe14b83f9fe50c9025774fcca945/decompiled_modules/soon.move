module 0x9fe8f4852ce7498aad3d3055cf8007d3d5debe14b83f9fe50c9025774fcca945::soon {
    struct SOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOON>(arg0, 6, b"SOON", b"MOON SOON !!!", b"We're going to the moon soon !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bc7824db35f35df7287dd1a954ce9be_d3cb619df4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

