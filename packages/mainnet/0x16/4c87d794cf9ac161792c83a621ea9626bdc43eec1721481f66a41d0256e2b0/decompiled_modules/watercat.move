module 0x164c87d794cf9ac161792c83a621ea9626bdc43eec1721481f66a41d0256e2b0::watercat {
    struct WATERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERCAT>(arg0, 6, b"WATERCAT", b"Watercat On Sui", b"Cat on the water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002539602.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATERCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

