module 0x45be8b47fe9e06f2bcc6baf1fd1d9359a6e1d8be1a3359773dab8b87525319b9::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICAT>, arg1: 0x2::coin::Coin<SUICAT>) {
        0x2::coin::burn<SUICAT>(arg0, arg1);
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 2, b"SUI CAT AI", b"CATAI", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/PQyPK03")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

