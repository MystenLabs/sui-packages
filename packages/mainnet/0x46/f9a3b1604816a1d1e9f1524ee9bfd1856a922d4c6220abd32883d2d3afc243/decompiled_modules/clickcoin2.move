module 0x46f9a3b1604816a1d1e9f1524ee9bfd1856a922d4c6220abd32883d2d3afc243::clickcoin2 {
    struct CLICKCOIN2 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLICKCOIN2>, arg1: 0x2::coin::Coin<CLICKCOIN2>) {
        0x2::coin::burn<CLICKCOIN2>(arg0, arg1);
    }

    fun init(arg0: CLICKCOIN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLICKCOIN2>(arg0, 2, b"CC", b"CLICK COIN", b"how many clicks did you click this week? share with your friends and get paid in crypto to click all day every day! NOT FINANCIAL ADVICE - USE AT YOUR OWN RISK. I AM NOT LIABLE FOR ANY LOSS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihawwzqtbvcuarwcy4dkabfzurxbjids5fma7rfs3s4utrgaoxbsm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLICKCOIN2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLICKCOIN2>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLICKCOIN2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLICKCOIN2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

