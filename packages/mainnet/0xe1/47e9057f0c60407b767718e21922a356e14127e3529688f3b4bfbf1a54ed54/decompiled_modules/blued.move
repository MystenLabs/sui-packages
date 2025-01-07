module 0xe147e9057f0c60407b767718e21922a356e14127e3529688f3b4bfbf1a54ed54::blued {
    struct BLUED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUED>(arg0, 6, b"BLUED", b"Blue Tidragon", b"We always been three, together we could rule the world. Legend of the story. Pump of the charts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdasdsa_d7878a8470.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUED>>(v1);
    }

    // decompiled from Move bytecode v6
}

