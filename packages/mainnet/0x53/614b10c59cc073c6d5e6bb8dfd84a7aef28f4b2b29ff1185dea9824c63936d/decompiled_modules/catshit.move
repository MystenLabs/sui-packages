module 0x53614b10c59cc073c6d5e6bb8dfd84a7aef28f4b2b29ff1185dea9824c63936d::catshit {
    struct CATSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSHIT>(arg0, 6, b"CATSHIT", b"Catshit coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATSHIT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSHIT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CATSHIT>>(v2);
    }

    // decompiled from Move bytecode v6
}

