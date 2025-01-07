module 0x41c1a34a13af18dc6a08e64f8fa4263cdb66f98382d04a4a6ad49805c45e25aa::craby {
    struct CRABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABY>(arg0, 6, b"Craby", b"CrabySui", b"Craby Has surfaced to Sui my Matt Furire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Remove_bg_ai_1727459232577_808d177a1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

