module 0xbaa6a2a621fb8bb8a95bd6f59c2f7e2ed0968480ef29347eb18671ef0b0143d9::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSUI", b"StonkSui", b"STONKSUI is an intentional misspelling of the word \"stocks\" often associated with a surreal meme featuring Meme Man standing in front of a stock market image with the caption \"Stonks\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STONKS_8bc0fc9fcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

