module 0xd269595879d3ca3a0d83a69c8260b1b9fc9d223b0ba5350b162abeed1d060898::wpr {
    struct WPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPR>(arg0, 8, b"WPR", b"Wooper", b"gemly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/194.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WPR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

