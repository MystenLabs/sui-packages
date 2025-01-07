module 0x55d352848ea8d2be107db47c18f4fbf4a049ad9b7557886d998d1befe2ffb149::weed {
    struct WEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEED>(arg0, 6, b"WEED", b"BLAZE", b" Blaze the waves of the Sui Sea with the puff-puff-pass master!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sss_79e1e5a453.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

