module 0x91f7f2a3d3466a91ed70843679b9c7699cfff2d0fe94055c33da4236f0624d7e::jesuspizza {
    struct JESUSPIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUSPIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUSPIZZA>(arg0, 6, b"Jesuspizza", b"JesusPizza", b"The temptation of cheese pizza, the blessing from Jesus makes every bite full of divine taste", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_6_234ab6624c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUSPIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUSPIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

