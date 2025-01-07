module 0x82c6b95de20fb7974ed39e3d6cf59fedfcbfacb6e09eda2bab562fed8a157d23::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FIONA>, arg1: 0x2::coin::Coin<FIONA>) {
        0x2::coin::burn<FIONA>(arg0, arg1);
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 9, b"FIONA", b"Fiona", b"Fiona", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeX5Yj1TxSf85erFwovDS5gVqVfGt3mQpn4iAxack4LNr")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIONA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIONA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

