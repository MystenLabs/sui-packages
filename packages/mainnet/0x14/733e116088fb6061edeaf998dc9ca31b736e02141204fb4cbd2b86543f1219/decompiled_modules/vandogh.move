module 0x14733e116088fb6061edeaf998dc9ca31b736e02141204fb4cbd2b86543f1219::vandogh {
    struct VANDOGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANDOGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANDOGH>(arg0, 6, b"VANDOGH", b"Van Dogh", b"The most talented dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Van_Dogh_8d6b608a1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANDOGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VANDOGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

