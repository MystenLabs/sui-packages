module 0xad1085fc2de49d213e464fd07c438f8ad5e9640854049d5c211b974f4e7fc98b::hds {
    struct HDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDS>(arg0, 6, b"HDS", b"HARLEY DAVID SUI", x"49542753204e4f54205448452044455354494e4154494f4e2c204954275320544845204a4f55524e45590a4c45542753204d414b45204120434f4d4d554e495459205448415420524944455320554e54494c20574520524541434820474f414c2044455354494e4154494f4e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/et1pm9ci_1ddaaf1693.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

