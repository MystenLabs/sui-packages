module 0x8428b289c851fb49c9686db3fb58ef20f9be45ba837ee5796d0196f4512f0180::usagi {
    struct USAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USAGI>(arg0, 6, b"Usagi", b"Chiikawa", b"Usagi means rabbit in Japanese. Some people also translate it as \"Usagi\" in Chinese, and some fans call him \"Brother Rabbit\". His birth day is January 22, 2019. Although he cannot speak, his most distinctive feature is his loud cry!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8901_1641fc19b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

