module 0x76047d35362199e03bb6e93f1d5ec379e247fb53f02350a6988024d2aa27418d::fubb {
    struct FUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBB>(arg0, 6, b"FUBB", b"Fubb Sui", b"Fubb is a tiny.Join us: https://x.com/FUBB_Sui | https://t.me/FUBBSui_Channel | https://suifubbfubb.lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.suifubbfubb.lol/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUBB>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

