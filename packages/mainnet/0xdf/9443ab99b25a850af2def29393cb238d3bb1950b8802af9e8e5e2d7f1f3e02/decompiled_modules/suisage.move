module 0xdf9443ab99b25a850af2def29393cb238d3bb1950b8802af9e8e5e2d7f1f3e02::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGE>(arg0, 6, b"Suisage", b"Sausage on Sui", b"Suisage is a playful and community-driven memecoin built on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibbpvm7bwamwkuhg65jh3fekiqazch4ikgchkqbsyklt4br5ufmm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISAGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

