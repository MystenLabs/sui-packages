module 0x645e99f0fe9136f401d00c9ef4478316f7a2507e4209251485c3670513bed75e::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"SharKui", b"KUI is not just a crypto, not just a meme; its a REVOLUTION!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_24_12_13_15_52_07_813_035508_1_21dd09944b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

