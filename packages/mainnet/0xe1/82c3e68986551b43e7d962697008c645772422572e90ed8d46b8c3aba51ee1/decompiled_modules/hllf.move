module 0xe182c3e68986551b43e7d962697008c645772422572e90ed8d46b8c3aba51ee1::hllf {
    struct HLLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLLF>(arg0, 9, b"HLLF", b"HALF LIFE", b"THIS MEME COIN IS DIFFERENT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e525aa95-4488-4e8a-ba73-e2102fa82596.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

