module 0x40280787f8b260473595c981b39fb12521b95b552846bf4760f8628354febbbf::louder {
    struct LOUDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOUDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOUDER>(arg0, 6, b"LOUDER", b"LOUDER ON SUI", b"$LOUDER The first Artist-Driven Memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y936u_VV_2_400x400_fb8ae75864.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOUDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOUDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

