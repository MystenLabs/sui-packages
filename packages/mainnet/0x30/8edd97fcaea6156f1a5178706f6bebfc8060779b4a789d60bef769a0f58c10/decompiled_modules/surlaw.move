module 0x308edd97fcaea6156f1a5178706f6bebfc8060779b4a789d60bef769a0f58c10::surlaw {
    struct SURLAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURLAW>(arg0, 6, b"SURLAW", b"WALRUS", b"Walrus is an innovative decentralized storage network for blockchain apps and autonomous agents. The Walrus storage system is being released today as a developer preview for Sui builders in order to gather feedback. We expect a broad rollout to other web3 communities very soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6280372940428133759_9a28adb346.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURLAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURLAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

