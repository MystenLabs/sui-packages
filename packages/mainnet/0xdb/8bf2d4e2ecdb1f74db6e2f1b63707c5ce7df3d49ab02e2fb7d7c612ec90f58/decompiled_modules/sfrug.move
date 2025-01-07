module 0xdb8bf2d4e2ecdb1f74db6e2f1b63707c5ce7df3d49ab02e2fb7d7c612ec90f58::sfrug {
    struct SFRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFRUG>(arg0, 6, b"SFrug", b"Frug On Sui", b"Dexscreener paid .Check here : https://frugsui.fun | https://t.me/FrugOnSui_Portal |https://x.com/FrugOnSui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_7b80ddc8ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

