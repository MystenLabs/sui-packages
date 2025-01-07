module 0x6101be064fa9970b62eddf4ddc8139b31e6c92d88f937e2139787d46f6ecc4fe::suisal {
    struct SUISAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAL>(arg0, 6, b"SUISAL", b"SuisalOnSui", b"A silly salmon making waves in the sui ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_130643_de5a7edd4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

