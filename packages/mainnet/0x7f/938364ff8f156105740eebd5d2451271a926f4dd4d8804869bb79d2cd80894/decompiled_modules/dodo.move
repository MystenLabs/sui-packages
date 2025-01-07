module 0x7f938364ff8f156105740eebd5d2451271a926f4dd4d8804869bb79d2cd80894::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 6, b"DODO", b"DODO Sui Inu", b"About Avatar Sui Inu: Avatar Sui Inu is a digital meme token, created to bring extraordinary financial freedom. By owning Avatar Sui Inu, you gain the power of financial liberation through the Sui blockchain. It is a symbol of empowerment in the world of decentralized finance, promising boundless", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_41d4d94aa8_bf217fa644.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

