module 0x6196759bb3c41a86917b9fbee7ace883cd0f59b12c6915f9a16721e101fa3ed8::dorae {
    struct DORAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORAE>(arg0, 6, b"DORAE", b"DORAESUI", b"AS THE LATEST MEME TOKEN, $DORAE IS FULL OF FUN AND ENDLESS POTENTIAL. JOIN US IN BRINGING WARMTH AND LIQUIDITY TO THE SUI CHAIN. Join now: https://doraesui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c237b8b765.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

