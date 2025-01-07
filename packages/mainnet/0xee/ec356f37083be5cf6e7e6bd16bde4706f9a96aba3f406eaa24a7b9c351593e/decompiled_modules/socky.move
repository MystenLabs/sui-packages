module 0xeeec356f37083be5cf6e7e6bd16bde4706f9a96aba3f406eaa24a7b9c351593e::socky {
    struct SOCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKY>(arg0, 6, b"SOCKY", b"Socky", b"Meet Socky, the original character of meme sui, he is just an ordinary sock who brings enthusiasm and laughter to those who see him!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_28_at_19_44_03_1_13a2252390.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

