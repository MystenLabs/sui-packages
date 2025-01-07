module 0xc303d8ccee85d00cb26aefaa50dc33ab8f64f480204216ab6c4555514192272d::pepenis {
    struct PEPENIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPENIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPENIS>(arg0, 9, b"PEPENIS", b"PEPENIS", b"A little playful frog with a huge boner.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.clubconflict.com/admin/imagehandler.ashx?type=pl&id=3096")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPENIS>(&mut v2, 69696969000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPENIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPENIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

