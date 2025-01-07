module 0xf26f14455e94435fd7bb386a26228b325f50e59f2d0e7f22fdcdca095c378b1e::octofunsui {
    struct OCTOFUNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOFUNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOFUNSUI>(arg0, 6, b"OctofunSui", b"Octopass", b"Octopass is coming to Sui market - A meme token acting like a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969749934.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOFUNSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOFUNSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

