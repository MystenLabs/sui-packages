module 0x70f7c86235ff0f47831b1fd9c834cdad854193c780020bc7c4202a4ddc195926::suicidesquad {
    struct SUICIDESQUAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDESQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDESQUAD>(arg0, 6, b"SuicideSquad", b"SUIcide Squad", b"Supervillain on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3601_99e552cd48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDESQUAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDESQUAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

