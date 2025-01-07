module 0xf98e311a68e30562cb85a88b069714f9fd819ded2f55a510083fd03719dc2e1e::SUWING {
    struct SUWING has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUWING>, arg1: 0x2::coin::Coin<SUWING>) {
        0x2::coin::burn<SUWING>(arg0, arg1);
    }

    fun init(arg0: SUWING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWING>(arg0, 2, b"SUWING", b"SUWING", b"SUWING 100000X FOR SWING & EARN 5 POINT EVERY TRANSACTION BUY AND SELL ON FLAMESWAP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma6VSvis3KVDvoBRueELsnF1BZbgcm1Qd2FM7v1iKfY57")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUWING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWING>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUWING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUWING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

