module 0xa0944fa2644dd6f6e1ff9218783e1ccae10f8b4dd7dc1fb8406118306acfa85d::cracked {
    struct CRACKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRACKED>(arg0, 6, b"CRACKED", b"Cracked Cat", b"Cracked Cat is absolutely cracked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/453634014_481601037941746_1016301456252608616_n_6d3f0aa752.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRACKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRACKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

