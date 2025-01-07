module 0x6b375f7546300c4d5b6ad38fdbbd0be3dd966db25658ea7d65739462bc4fe22d::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOAT>, arg1: 0x2::coin::Coin<GOAT>) {
        0x2::coin::burn<GOAT>(arg0, arg1);
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"GOAT", b"Goatseus Maximus", b"Goatseus Maximus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS8vx944JuJmWDzgdMr247wr4TzVpTCwAjdn1sc3hvD5Y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

