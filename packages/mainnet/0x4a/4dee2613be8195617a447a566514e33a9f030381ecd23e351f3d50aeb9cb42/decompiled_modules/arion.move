module 0x4a4dee2613be8195617a447a566514e33a9f030381ecd23e351f3d50aeb9cb42::arion {
    struct ARION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARION>(arg0, 6, b"ARION", b"ARION SUI", x"5769636b65646c7920636c6576657220616e6420727574686c6573732e0a0a4120706c617966756c206d656e616365207772617070656420696e20706f7765722e0a0a52756c6572206f66204d6f6f6e73686f7420616e64206d6173746572206f6620746865206461726b65737420736b6965732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Ssknc_Ag_400x400_fb19cae628.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARION>>(v1);
    }

    // decompiled from Move bytecode v6
}

