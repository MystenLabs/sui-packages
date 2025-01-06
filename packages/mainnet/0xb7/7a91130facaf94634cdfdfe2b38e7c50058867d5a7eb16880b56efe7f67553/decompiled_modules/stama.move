module 0xb77a91130facaf94634cdfdfe2b38e7c50058867d5a7eb16880b56efe7f67553::stama {
    struct STAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMA>(arg0, 6, b"STAMA", b"SUITAMA", b"$STAMA is superhero who dreams of becoming famous.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008158_d5f27d8b30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

