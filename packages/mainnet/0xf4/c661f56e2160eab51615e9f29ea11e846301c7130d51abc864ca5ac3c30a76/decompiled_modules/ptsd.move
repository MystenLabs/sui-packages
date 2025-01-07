module 0xf4c661f56e2160eab51615e9f29ea11e846301c7130d51abc864ca5ac3c30a76::ptsd {
    struct PTSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTSD>(arg0, 6, b"PTSD", b"PTSD SUI", b"Degens - once frolicking in the fields of decentralized dreams, now suffer from a new affliction  Meme Coin PTSD. [ Telegram :  Yes] [ Twitter :  Yes] [ Website :  Yes]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/pfp_7b1b0aaa55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

