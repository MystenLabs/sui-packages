module 0xb33bc2e924d966676406e20591cc371ca4a6756b6b7db84299896b3bf34c6f36::zogi {
    struct ZOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOGI>(arg0, 6, b"Zogi", b"Zogi on sui", b"Zogi came from a distant corner of the galaxy Sui gma 9.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicpen3dzp2vwskpukhi44o4pmkurynbcsnfoovtcd2scvwqvofcni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZOGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

