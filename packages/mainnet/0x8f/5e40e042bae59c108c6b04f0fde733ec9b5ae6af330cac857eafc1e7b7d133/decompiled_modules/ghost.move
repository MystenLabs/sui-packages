module 0x8f5e40e042bae59c108c6b04f0fde733ec9b5ae6af330cac857eafc1e7b7d133::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GHOST", b"GHOSUI", b"GHOST on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_28_9d1f651cee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

