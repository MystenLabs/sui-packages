module 0xe2dce11ca1ea116346beeffc13fea993539134e601d3aca9fcf0d0f92e182360::deers {
    struct DEERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEERS>(arg0, 6, b"DEERS", b"DEERSEA", b"DEER DEER DEER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/preview_b7aa9f51d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

