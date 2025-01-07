module 0x7d8d1595f8e61cc6e6d2180c20e7a27cf7bf97e87aa78c96945aeb74e1e7fa0f::bitcorn {
    struct BITCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCORN>(arg0, 6, b"BITCORN", b"Bitcorn On Sui", b"The term \"bitcorn\" was born around 2017, amid the explosion of cryptocurrencies and memes in the community. It comes from social media users and online forums making fun of and making puns between Bitcoin and images of corn. Since then, \"bitcorn\" has become part of meme culture in the cryptocurrency community, often used to express humor or irony about the value of Bitcoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_5651f28ce5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

