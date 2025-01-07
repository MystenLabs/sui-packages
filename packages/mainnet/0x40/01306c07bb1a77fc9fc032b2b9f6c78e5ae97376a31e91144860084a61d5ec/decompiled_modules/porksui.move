module 0x4001306c07bb1a77fc9fc032b2b9f6c78e5ae97376a31e91144860084a61d5ec::porksui {
    struct PORKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORKSUI>(arg0, 6, b"Porksui", b"PORK SUI", b"Join the love of pork sui venture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241011_161442_Chrome_fedc1bef33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

