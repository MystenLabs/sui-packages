module 0xea3b7e7faaffc9ba76e1d326644fa9ef99379a4c535bbb68f6c7fbc361851fb0::bossy {
    struct BOSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSSY>(arg0, 6, b"BOSSY", b"Bossy", b"Introducing $BOSSY: Where Boss Pepe reigns supreme, memes bow down and wallets get pumped! Join the hoppiest hustle on SUI and let's meme our way to the top!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bossy_logo_6b6dd008b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

