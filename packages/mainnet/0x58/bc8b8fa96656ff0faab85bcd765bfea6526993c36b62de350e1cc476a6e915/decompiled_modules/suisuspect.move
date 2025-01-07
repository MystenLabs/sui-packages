module 0x58bc8b8fa96656ff0faab85bcd765bfea6526993c36b62de350e1cc476a6e915::suisuspect {
    struct SUISUSPECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUSPECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUSPECT>(arg0, 6, b"SuiSuspect", b"Luigi Mangione", b"luigi mangione the suspected UHC assassin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003836_32c391dde2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUSPECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUSPECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

