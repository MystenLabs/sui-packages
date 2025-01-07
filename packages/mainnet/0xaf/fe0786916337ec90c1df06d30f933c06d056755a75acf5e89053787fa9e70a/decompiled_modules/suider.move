module 0xaffe0786916337ec90c1df06d30f933c06d056755a75acf5e89053787fa9e70a::suider {
    struct SUIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDER>(arg0, 6, b"SUIDER", b"Suiderman", b"SUIDERMAN, born as a joke inspired by the SUIMAN, is more than just another meme coin. It combines the fun of memes with a mission to spread happines among suiperhero lovers. SUIDERMAN quickly captivated the online community with its MEME image and aims to make a difference through its robust utility, community engagement, and entertainment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIDERMAN_LOGO_eaf845083f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

