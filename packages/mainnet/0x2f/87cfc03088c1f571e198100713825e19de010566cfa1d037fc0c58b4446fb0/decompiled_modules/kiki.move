module 0x2f87cfc03088c1f571e198100713825e19de010566cfa1d037fc0c58b4446fb0::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 6, b"KIKI", b"kiki the cat", b"kiki is the cutest mf you will ever see on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/kiki_tha_cat_copy_040f767c98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

