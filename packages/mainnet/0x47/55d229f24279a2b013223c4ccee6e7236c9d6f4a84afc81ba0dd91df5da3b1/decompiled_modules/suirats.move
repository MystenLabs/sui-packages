module 0x4755d229f24279a2b013223c4ccee6e7236c9d6f4a84afc81ba0dd91df5da3b1::suirats {
    struct SUIRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRATS>(arg0, 9, b"SUIRATS", b"Sui Rats", b"Sui Rats Mascot Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1735559781341900800/-8zyxm9D_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRATS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

