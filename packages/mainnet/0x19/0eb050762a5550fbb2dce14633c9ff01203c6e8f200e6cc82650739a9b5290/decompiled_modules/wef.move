module 0x190eb050762a5550fbb2dce14633c9ff01203c6e8f200e6cc82650739a9b5290::wef {
    struct WEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEF>(arg0, 6, b"WEF", b"WEASELFLY", b"Introducing Weasel fly: Meme Magic, Tax-Free!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8843f680e54c2039bdefde9c832150b7_removebg_preview_88be42bb8b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

