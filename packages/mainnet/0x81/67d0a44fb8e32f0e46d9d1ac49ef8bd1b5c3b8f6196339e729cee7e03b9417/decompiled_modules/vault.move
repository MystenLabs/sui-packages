module 0x8167d0a44fb8e32f0e46d9d1ac49ef8bd1b5c3b8f6196339e729cee7e03b9417::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: 0x2::coin::Coin<VAULT>) {
        0x2::coin::burn<VAULT>(arg0, arg1);
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"CETUS", b"Cetus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-2eERL1Bati.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT>>(v1);
    }

    public fun make(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT> {
        0x2::coin::mint<VAULT>(arg0, arg1, arg2)
    }

    public entry fun make_to(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

