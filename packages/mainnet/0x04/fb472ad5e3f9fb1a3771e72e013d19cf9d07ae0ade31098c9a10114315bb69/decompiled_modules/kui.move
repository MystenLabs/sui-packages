module 0x4fb472ad5e3f9fb1a3771e72e013d19cf9d07ae0ade31098c9a10114315bb69::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"SharKui", b"KUI is not just a crypto, not just a meme; its a REVOLUTION!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tz5m_ZX_L_400x400_e89d1236fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

