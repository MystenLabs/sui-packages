module 0xb6646dd730976a877093da2983b54399f1395768b7db6e4c74e9217a3554e947::TSUIKA {
    struct TSUIKA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TSUIKA>, arg1: 0x2::coin::Coin<TSUIKA>) {
        0x2::coin::burn<TSUIKA>(arg0, arg1);
    }

    fun init(arg0: TSUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUIKA>(arg0, 2, b"TSUIKA", b"TSUIKA", b"TSUIKA Based on the integration of Web3 and NFT Built on SUI Network, the values displayed by the concept of the DEJITARU are consistent with the core values of the social media and community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPwfChJx69yZVzgvJKGtE9S2AmvvsxSSjjH3MmzLzwzgv")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TSUIKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TSUIKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

