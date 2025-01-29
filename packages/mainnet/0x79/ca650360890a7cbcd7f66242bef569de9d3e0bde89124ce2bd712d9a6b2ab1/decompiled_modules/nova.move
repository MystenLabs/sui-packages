module 0x79ca650360890a7cbcd7f66242bef569de9d3e0bde89124ce2bd712d9a6b2ab1::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"NOVA Visualiser", b"NOVA is a 3D token visualization platform that transforms blockchain data into an interactive galaxy of wallet holders. With real-time tracking, cross-chain support, and intuitive visuals, NOVA makes it easy to explore token ecosystems like never before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_175308_292_63ed819874.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

