module 0xfbb869d758ed8298db6a8ca5d5fb4598dc7d99f8fb8ba322e8e909a70c3728f0::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 6, b"LOVE", b"LOVE ON SUI", b"Welcome to $LOVEon SUI blockchain! $LOVE is the meme coin that unites ANIME lovers and crypto enthusiasts! Join us in creating the next big wave of Fan Tokens on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/an_e46b97152e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

