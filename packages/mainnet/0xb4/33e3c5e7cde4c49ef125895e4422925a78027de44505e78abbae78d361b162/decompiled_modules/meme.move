module 0xb433e3c5e7cde4c49ef125895e4422925a78027de44505e78abbae78d361b162::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"Meme token", b"Meme coins are cryptocurrencies inspired by internet memes or cultural trends, often created as jokes or for entertainment purposes. Popular examples include Dogecoin (DOGE) and Shiba Inu (SHIB), which gained significant attention due to community support", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/f5294ccf-a252-460e-b265-9526b2298c85.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

