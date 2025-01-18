module 0xc20a25b93be3db298b4a0d97fd869bde2b44b2c992ca37c1cadb32e179bd9d40::trumpwif {
    struct TRUMPWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWIF>(arg0, 6, b"TRUMPWIF", b"Trump wif hat", b"Social and website will be listed here! Dont miss out!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6191_fc9d5f1699.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

