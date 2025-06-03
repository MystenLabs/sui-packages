module 0xbeca1ed405972fbf0839396f6eeaac532f7450715aa64fdddc969390ee56ae1::tert {
    struct TERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERT>(arg0, 6, b"TERT", b"Tert On Sui", b"Tert the new mascot of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaky6743qawx5myuxopgjzdu3cwiqwnau6uhripz45xmrbl5d24ma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

