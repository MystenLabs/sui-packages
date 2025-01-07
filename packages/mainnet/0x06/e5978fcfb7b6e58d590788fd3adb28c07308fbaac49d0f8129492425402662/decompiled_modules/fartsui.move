module 0x6e5978fcfb7b6e58d590788fd3adb28c07308fbaac49d0f8129492425402662::fartsui {
    struct FARTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTSUI>(arg0, 6, b"FARTSUI", b"Fart Sui", b"Every Single Meme Has A Narrative", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salinan_dari_Desain_Tanpa_Judul_2_950b97052d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

