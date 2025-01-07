module 0x57788e291373f223be4e09e7d8bf0e05db9a11c3cc2df6b32abdab30329f2918::SUIFROG {
    struct SUIFROG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIFROG>, arg1: 0x2::coin::Coin<SUIFROG>) {
        0x2::coin::burn<SUIFROG>(arg0, arg1);
    }

    fun init(arg0: SUIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFROG>(arg0, 2, b"SUIFROG", b"SUIFROG", b"SUIFROG is a community meme token - built on Sui Network. The token is completely community driven. Rest of the total supply will mainly be used in future rewards for best meme/art creators, staking, etc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmad3jT6ePQsjzAkwLmqjBSESj7abfnXQURkkhwWBSiDgS")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFROG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIFROG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

