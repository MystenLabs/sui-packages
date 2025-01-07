module 0x8c4155a9d6e35c962c2a266354301a829798d04fde3e3d6652c60ef65ce772da::suiiii {
    struct SUIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIII>(arg0, 6, b"Suiiii", b"Suuiii", b"Suuiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000137425_a059a38985.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

