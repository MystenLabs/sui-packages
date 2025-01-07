module 0x2027d47b3ae6933c081528aca3ccc86d49b227f337ac78a99e653fd2de0b0b7d::dgavenfers {
    struct DGAVENFERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGAVENFERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGAVENFERS>(arg0, 6, b"DGAVENFERS", b"DOGS AVENGERS", b"ASSEMBLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_08_25_A_s_20_44_44_ace6a7af_a9d958fbb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGAVENFERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGAVENFERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

