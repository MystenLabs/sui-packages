module 0x6554b90ae1e2b97964d4a9f74a5fd21a9337d437a1a837c7b8783499857713c8::peipei {
    struct PEIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEIPEI>(arg0, 6, b"PEIPEI", b"PEIPEI SUI", b"$PEIPEI the frog is a twist on Matt Furies famous Pepe The Frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_clean_bg_removebg_preview_81c1b129b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

