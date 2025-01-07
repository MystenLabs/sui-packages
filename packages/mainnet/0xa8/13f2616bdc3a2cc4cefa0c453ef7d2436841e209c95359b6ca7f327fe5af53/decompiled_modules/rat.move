module 0xa813f2616bdc3a2cc4cefa0c453ef7d2436841e209c95359b6ca7f327fe5af53::rat {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAT>(arg0, 6, b"RAT", b"rat", b"Ugliest rat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ratxd_ce843ce98e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

