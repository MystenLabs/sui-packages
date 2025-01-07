module 0x780534c372b1153298be5eddbd9be2b7c104ee784abe7216d3f2f160289158fb::bvb {
    struct BVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVB>(arg0, 6, b"BVB", b"Borussia Dortmund", b"Ballspielverein Borussia 09 e. V. Dortmund, often known simply as Borussia Dortmund or by its initialism BVB, is a German professional sports club based in Dortmund", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Borussia_Dortmund_logo_svg_483b45c091.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BVB>>(v1);
    }

    // decompiled from Move bytecode v6
}

