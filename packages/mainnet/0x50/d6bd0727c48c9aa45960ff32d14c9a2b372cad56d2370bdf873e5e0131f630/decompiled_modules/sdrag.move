module 0x50d6bd0727c48c9aa45960ff32d14c9a2b372cad56d2370bdf873e5e0131f630::sdrag {
    struct SDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAG>(arg0, 9, b"SDRAG", b"Sui Dragon", b"SDRAG is Meme on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845527133801926656/aYkz8wT8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDRAG>(&mut v2, 490000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

