module 0x9fa945b9b7e9e3ee07cf3505254d24431824978bdb3ccef6a0f13b760b3c7ffa::shizn {
    struct SHIZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIZN>(arg0, 6, b"SHIZN", b"SUISHIZN", b"$SHIZN a combination of Rice and Fresh Fish. Should be in your bag. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001379_ad4e191625.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIZN>>(v1);
    }

    // decompiled from Move bytecode v6
}

