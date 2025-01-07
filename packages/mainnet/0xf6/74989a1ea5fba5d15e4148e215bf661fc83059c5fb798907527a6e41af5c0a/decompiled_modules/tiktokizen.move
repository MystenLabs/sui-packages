module 0xf674989a1ea5fba5d15e4148e215bf661fc83059c5fb798907527a6e41af5c0a::tiktokizen {
    struct TIKTOKIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKTOKIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKTOKIZEN>(arg0, 9, b"TIKTOKIZEN", b"Tiktok", b"TikTok, whose mainland Chinese and Hong Kong counterpart is Douyin, is a short-form video hosting service owned by Chinese internet company ByteDance. It hosts user-submitted videos, which can range in duration from three seconds to 60 minutes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad4da91e-5981-4c3e-98a2-0ae0f5ee57a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKTOKIZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKTOKIZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

