module 0x5f13bb7292bfd9d15cf41faecc6904447833fa13242c90c8eedce0000614de62::ringg {
    struct RINGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINGG>(arg0, 6, b"RINGG", b"Ringgle", b"BRINGING CHANGE ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734335997137.58")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RINGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

