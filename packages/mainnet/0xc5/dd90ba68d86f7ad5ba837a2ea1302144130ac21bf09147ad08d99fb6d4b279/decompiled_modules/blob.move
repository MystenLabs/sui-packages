module 0xc5dd90ba68d86f7ad5ba837a2ea1302144130ac21bf09147ad08d99fb6d4b279::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLOB>, arg1: 0x2::coin::Coin<BLOB>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLOB>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLOB>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"$BLOB", b"Blob On Sui", b"$Blob, the memecoin thats here to take the Sui Network by storm and leave everyone in stitches. Now imagine that blob stumbling onto the blockchain, wiggling its way through the crypto world, and causing a frenzy. Thats $Blob, a memecoin thats more than just a squishy face; its a movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blob_logo_495677f199.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BLOB>, arg1: 0x2::coin::Coin<BLOB>) : u64 {
        0x2::coin::burn<BLOB>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BLOB>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BLOB> {
        0x2::coin::mint<BLOB>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

