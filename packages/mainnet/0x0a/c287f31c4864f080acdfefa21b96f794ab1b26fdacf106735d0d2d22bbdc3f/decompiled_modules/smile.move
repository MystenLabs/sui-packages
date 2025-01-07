module 0xac287f31c4864f080acdfefa21b96f794ab1b26fdacf106735d0d2d22bbdc3f::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"Smile", b"smile123", b"smile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J_5t_HQ_0_400x400_a2e19c5dde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

