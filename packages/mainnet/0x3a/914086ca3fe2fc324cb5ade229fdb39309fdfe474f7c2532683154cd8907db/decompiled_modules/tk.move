module 0x3a914086ca3fe2fc324cb5ade229fdb39309fdfe474f7c2532683154cd8907db::tk {
    struct TK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK>(arg0, 6, b"TK", b"TIKTOK", b"TikTok, whose mainland Chinese and counterpart is Douyin is a short-form video hosting service owned by Chinese internet company ByteDance. It hosts user-submitted videos, which can range in duration from three seconds to 60 minutes.It can be accessed with a smart phone app.buy Bribe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bfa007051abd407f202ce4b8a6b1571e_516eb30d4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TK>>(v1);
    }

    // decompiled from Move bytecode v6
}

