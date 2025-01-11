module 0x1972d662cf80b010cb656adcc104875ef3de61ca1ba0033e65945c33ab16aca6::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAIFU>(arg0, 6, b"WAIFU", b"Waifu AI  by SuiAI", b"Waifu is an AI agent developed for the SUI Network, a decentralized blockchain platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8082_eb75cf64f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIFU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

