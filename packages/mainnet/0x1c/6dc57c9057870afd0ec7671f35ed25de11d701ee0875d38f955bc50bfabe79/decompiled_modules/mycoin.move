module 0x1c6dc57c9057870afd0ec7671f35ed25de11d701ee0875d38f955bc50bfabe79::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, x"550053445420", b"TES UD", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdmzy6umk5drqgmaa7fti73thnxiy5c6hxcqqc4g72yfldv42weu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

