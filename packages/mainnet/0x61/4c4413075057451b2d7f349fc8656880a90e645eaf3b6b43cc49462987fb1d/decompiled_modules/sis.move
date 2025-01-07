module 0x614c4413075057451b2d7f349fc8656880a90e645eaf3b6b43cc49462987fb1d::sis {
    struct SIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIS>(arg0, 9, b"SIS", b"SUiS", b"SUiS coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

