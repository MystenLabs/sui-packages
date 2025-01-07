module 0xd915553f471217677bd91e33815484c8e8e9a00d6670583f661cc12aa71d934e::iab {
    struct IAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAB>(arg0, 6, b"IAB", b"Hello, I am Bonkman.", b"Reward early pioneers with airdropsWe apologize for the delay. We want to make sure the platform is pristine. Itll be worth it. Trust.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018274_0df036487d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

