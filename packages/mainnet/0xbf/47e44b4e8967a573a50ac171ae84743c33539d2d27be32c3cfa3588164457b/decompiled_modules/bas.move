module 0xbf47e44b4e8967a573a50ac171ae84743c33539d2d27be32c3cfa3588164457b::bas {
    struct BAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAS>(arg0, 6, b"BAS", b"ON A FAIT 300K SUR VOTRE DOS", b"BRIGANDE ANTI SMIC HAHAHAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spy_c3d5883d30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

