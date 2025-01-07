module 0xac39d96d1064b29acdfbe5bd83c66d98e5c4e7ac3ed95717dc3cfba81a34649f::TOADY {
    struct TOADY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOADY>, arg1: 0x2::coin::Coin<TOADY>) {
        0x2::coin::burn<TOADY>(arg0, arg1);
    }

    fun init(arg0: TOADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOADY>(arg0, 9, b"TOADY", b"TOADY SUI", b"TOADY SUI was born. 100% of the tokens belong to the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmawiGYqrix3yKSpkEYRW4tJdKqxnZS925qPA7zsajwkxf")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOADY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOADY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOADY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOADY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

