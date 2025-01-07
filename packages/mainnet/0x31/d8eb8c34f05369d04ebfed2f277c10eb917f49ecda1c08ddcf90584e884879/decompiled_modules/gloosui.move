module 0x31d8eb8c34f05369d04ebfed2f277c10eb917f49ecda1c08ddcf90584e884879::gloosui {
    struct GLOOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOSUI>(arg0, 6, b"GLOOSUI", b"GLOO", b"Hi ! I'm gloo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/magical_Gloo_48703d6da3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

