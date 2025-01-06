module 0xf3d9907b8343b6fe7079433f85325ff56df81c2987005bea997df0aaf2a9ad65::aimaga {
    struct AIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMAGA>(arg0, 6, b"AIMAGA", b"President.exe", b"Meme project on Solana. With trump AI answering questions or request, now on Telegram and will be in video form in Twitch later on. PRESIDENT.EXE is more than just an AIits constantly updated with real-time data from Trumps latest speeches and public appearances. Every day, the bot evolves, reflecting his most recent actions. Whether he's giving a rally speech, making bold claims, or firing off comments, youll see it reflected in President.exeas if youre talking to the man himself in real time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_D_D_D_D_N_79fb594e2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

