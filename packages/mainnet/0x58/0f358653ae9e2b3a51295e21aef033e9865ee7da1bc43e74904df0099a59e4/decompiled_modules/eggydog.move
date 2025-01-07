module 0x580f358653ae9e2b3a51295e21aef033e9865ee7da1bc43e74904df0099a59e4::eggydog {
    struct EGGYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGYDOG>(arg0, 6, b"EGGYDOG", b"EggyDog", b"The one and only egg shaped dog coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eggdog_4e639512e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

