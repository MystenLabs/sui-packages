module 0xb065f3b30699e6e64aec9480f697fdbfb554d88601998b9540072f3681ec696b::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 9, b"STONKS", b"Stonks", b"Stonks is an intentional misspelling of the word \"stocks\" which is often associated with a surreal meme featuring the character Meme Man standing in front of a picture representing the stock market followed by the caption \"Stonks.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21b058bc-9010-4267-b6e1-f58ed6f6e95c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

