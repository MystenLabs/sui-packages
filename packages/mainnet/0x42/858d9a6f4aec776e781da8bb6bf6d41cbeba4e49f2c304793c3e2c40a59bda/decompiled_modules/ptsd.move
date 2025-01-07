module 0x42858d9a6f4aec776e781da8bb6bf6d41cbeba4e49f2c304793c3e2c40a59bda::ptsd {
    struct PTSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTSD>(arg0, 6, b"PTSD", b"PTSD SUI", b"Degens - once frolicking in the fields of decentralized dreams, now suffer from a new affliction  Meme Coin PTSD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_a70ec1d36d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

