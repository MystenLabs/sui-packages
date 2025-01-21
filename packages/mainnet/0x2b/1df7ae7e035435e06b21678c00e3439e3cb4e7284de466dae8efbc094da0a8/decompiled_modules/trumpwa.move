module 0x2b1df7ae7e035435e06b21678c00e3439e3cb4e7284de466dae8efbc094da0a8::trumpwa {
    struct TRUMPWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWA>(arg0, 6, b"TRUMPWA", b"Trump Whale Agent", b"Trump whale agent will help minimize your crypto losses and maximize gains. Trump whale is one of its kind. We are excited for our website launch immediately we will have a live video chat on telegram once onboarding our ? Investors that will hold long after bonding curve is reached.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6224_0ae8a3405a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

