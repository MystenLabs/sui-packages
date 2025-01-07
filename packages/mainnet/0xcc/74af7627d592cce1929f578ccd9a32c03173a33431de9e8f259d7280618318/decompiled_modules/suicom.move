module 0xcc74af7627d592cce1929f578ccd9a32c03173a33431de9e8f259d7280618318::suicom {
    struct SUICOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOM>(arg0, 6, b"SUICom", b"SUICommunity", b"SUI Community token. No Telegram, Twitter or Website, Just the Community of SUI coming together. Together we Rise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_04_225436_5055b8b6c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

