module 0x6d1aa772e638a967a2f5921950ecfbfaf2c26865b8dc3b252a2322f785efb561::suinicinu {
    struct SUINICINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINICINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINICINU>(arg0, 9, b"SUINICINU", b"Suinic Inu", b"Meet SuinicInu, the speedy sensation inspired by the iconic cartoon character, Sonic the Hedgehog! As the fastest runner on the Sui network, SuinicInu is not just a meme; it's a community-driven project dedicated to providing a safe and enjoyable experience for everyone. Telegram: https://t.me/suinicinu X: https://x.com/suinic Website: https://suinicinu.run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINICINU>(&mut v2, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINICINU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINICINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

