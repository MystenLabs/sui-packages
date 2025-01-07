module 0xce0b9b40666e50d1fa964561bef82b65c7a9709d48f5b15b42d35779ca4bbd0e::wshit {
    struct WSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSHIT>(arg0, 6, b"WSHIT", b"WojakSlimeHawkImaginateToryinu", b"We got tired of rugs. Bonding through friendship!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/realshit_48171149d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

