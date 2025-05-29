module 0x7692d4a115dd7b872fc769075f986d785201d8294132df44db98bf24cd55d305::jigsui {
    struct JIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGSUI>(arg0, 6, b"JIGSUI", b"Jiggly on SUI", b"MOONBAGS IO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfipe5tlivstbyqbkigot7k45a2mwmoeywgeqlsozyjce4ratktu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

