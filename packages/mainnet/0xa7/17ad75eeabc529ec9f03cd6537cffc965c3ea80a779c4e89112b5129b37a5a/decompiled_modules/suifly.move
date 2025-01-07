module 0xa717ad75eeabc529ec9f03cd6537cffc965c3ea80a779c4e89112b5129b37a5a::suifly {
    struct SUIFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLY>(arg0, 6, b"SUIFLY", b"SuiFly", b"A community-driven meme coin on Sui Network, representing freedom, creativity, and limitless possibilities. Playful, adaptable, and ready to soar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ugo_Vzs8b_400x400_cd59fb4604.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

