module 0x75055c6d88ba758659e4c85128cfb37345d86b4ba60c2533b544cdc67ebda826::lobdog {
    struct LOBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBDOG>(arg0, 6, b"LOBDOG", b"Dlogster", b"unda da sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_471259a741.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

