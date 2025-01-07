module 0x3cf505aab0149754241b30d037105529e91eb9bcc1fcce316a1a5b720b2d6f94::shinsui {
    struct SHINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINSUI>(arg0, 6, b"Shinsui", b"SHINSUI The Shiba Origins", b"There Used to Be Multiple Kinds Of Shiba Before World War II, there were three types of Shibas - the Mino, the Sanin, and the Shinsui. named for the regions where they originated. todays Shiba Inu is most similar to the Shinsui, but all three contributed to hte modern breed..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shinsui_d2166d58d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

