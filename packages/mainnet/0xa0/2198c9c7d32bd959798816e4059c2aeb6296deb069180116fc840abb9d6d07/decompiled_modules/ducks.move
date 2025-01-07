module 0xa02198c9c7d32bd959798816e4059c2aeb6296deb069180116fc840abb9d6d07::ducks {
    struct DUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKS>(arg0, 6, b"DUCKS", b"DOUG THE DUCK", b"Hello, I'm $DUCKS, the strongest Duck on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Et_rq_MY_400x400_56b27e9706.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

