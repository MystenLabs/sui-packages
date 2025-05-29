module 0xe45fd16a5f8cfd108d4bb37fe3421811b94790638655b227912f99c2300ff0ba::jigglysui {
    struct JIGGLYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLYSUI>(arg0, 6, b"JIGGLYSUI", b"Jiggly On SUI", b"Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfipe5tlivstbyqbkigot7k45a2mwmoeywgeqlsozyjce4ratktu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLYSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

