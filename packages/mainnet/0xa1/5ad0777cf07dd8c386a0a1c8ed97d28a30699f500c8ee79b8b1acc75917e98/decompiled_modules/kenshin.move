module 0xa15ad0777cf07dd8c386a0a1c8ed97d28a30699f500c8ee79b8b1acc75917e98::kenshin {
    struct KENSHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENSHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENSHIN>(arg0, 6, b"Kenshin", b"Kenshin -Hitokiri Battosai", b"Himura Kenshin is the main protagonist and titular character of the Rurouni Kenshin series. He is known as the legendary hitokiri of the Meiji Revolution, Hitokiri Battsai , more properly named Himura Battsai . Kenshin has spent ten years traveling Japan as a rurouni in search of redemption, carrying a sakabat with the vow to never kill again following his service in the Bakumatsu as an assassin for the Imperialist cause. In 1878, he arrives in Tokyo and takes up residence at the Kamiya Dj, where his vow is tested as he fights to keep the country's peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_SI_Nfz_FQ_400x400_12544d58f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENSHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENSHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

