module 0x3d076f4689315390f715deb49aaff6547ba09cbaf38ed6d9f2c583c74b9ae6f7::smyro {
    struct SMYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMYRO>(arg0, 6, b"SMYRO", b"SuiMyro", b"SuiMyro ($MYRO) is a community driven memecin inspired by solanas popularr myro token,with the goal of uniting sui ethusiast through fun, accessible and decentralised engagement . Rooted in a love for lighthearted internet culture, SuiMyro brings exclusive digital collectibles, community voting rights and a platform for meme sharing .With a focus on low fees and fast transactions on sui ,sui myro aims to become a staple for meme culture in the ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/myrro_309bd40301.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

