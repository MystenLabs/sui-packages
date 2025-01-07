module 0xc5ed0e8b38efb9bb3a69e60772a2f3b8fa6038e095dfab7777294f645e9c7614::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"Labubu", b"LabubuOnSUI", x"4c6162756275206973206120676c6f62616c206c656164696e6720746f79206368617261637465722e0a466f6c6c6f7720666f722052656c65617365732c204e65777320616e64204576656e74732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/labubu_126b2e8e68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

