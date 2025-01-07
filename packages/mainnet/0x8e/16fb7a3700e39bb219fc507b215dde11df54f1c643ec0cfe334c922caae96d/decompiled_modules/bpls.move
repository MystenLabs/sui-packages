module 0x8e16fb7a3700e39bb219fc507b215dde11df54f1c643ec0cfe334c922caae96d::bpls {
    struct BPLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPLS>(arg0, 6, b"BPLS", b"Bitch Please!", b"The Legendary Bitch, Please! Meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lol_f405095f7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

