module 0x7fa30766fb75bcbd1f6334f6484a5155e8e4105d6ec94fb0e70ce2d522c099f3::mushlo {
    struct MUSHLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHLO>(arg0, 9, b"MUSHLO", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9b349d5-2340-46cf-a1cc-d0e4c5f004b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSHLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

