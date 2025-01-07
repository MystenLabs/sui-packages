module 0xedcfaaed1bb4c4c6eba186b58c24e2f5a5ee09df71e6ce6414a9540ee4374cd2::sonkey {
    struct SONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONKEY>(arg0, 6, b"SONKEY", b"Sonkey", b"Meet $SONKEY The First Monkey on SUI,brother of PONKE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n8cg1fz9_400x400_414db7b648.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

