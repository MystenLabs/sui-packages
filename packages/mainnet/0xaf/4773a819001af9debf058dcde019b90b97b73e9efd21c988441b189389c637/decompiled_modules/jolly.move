module 0xaf4773a819001af9debf058dcde019b90b97b73e9efd21c988441b189389c637::jolly {
    struct JOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLLY>(arg0, 6, b"Jolly", b"Sui Santa", b"Christmas has come early for Sui Santa buyers. Here is your chance to make your kids dreams come true.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/santa_f4d41b4850.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

