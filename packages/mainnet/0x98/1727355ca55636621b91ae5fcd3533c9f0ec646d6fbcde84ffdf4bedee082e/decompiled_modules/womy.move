module 0x981727355ca55636621b91ae5fcd3533c9f0ec646d6fbcde84ffdf4bedee082e::womy {
    struct WOMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMY>(arg0, 6, b"WOMY", b"Sui Womy", b"$WOMY king of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_37_894dcc2640.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

