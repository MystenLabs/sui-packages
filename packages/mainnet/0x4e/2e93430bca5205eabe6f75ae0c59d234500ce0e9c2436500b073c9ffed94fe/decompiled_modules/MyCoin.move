module 0x4e2e93430bca5205eabe6f75ae0c59d234500ce0e9c2436500b073c9ffed94fe::MyCoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct MyCoin has store, key {
        id: 0x2::object::UID,
    }

    public fun join(arg0: &mut 0x2::coin::Coin<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::join<MYCOIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(arg0, arg1, arg3), arg2);
    }

    public fun transfer(arg0: &mut 0x2::coin::Coin<MYCOIN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::split<MYCOIN>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"AWC", b"AlexWakerCoin", b"AlexWaker coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

