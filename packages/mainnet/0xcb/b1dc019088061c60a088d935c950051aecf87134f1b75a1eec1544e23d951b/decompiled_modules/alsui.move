module 0xcbb1dc019088061c60a088d935c950051aecf87134f1b75a1eec1544e23d951b::alsui {
    struct ALSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALSUI>(arg0, 6, b"ALSUI", b"Paca Suinami", b"Al the Alpaca is diving headfirst into the crypto world as the newest face of SUI meme coins. With his flippers steering towards making an upcoming splash on the highly successful PCA Finance site, he aims to glide to an all time high in the meme coin market along the way. Al's journey is all about riding the tides of crypto volatility, winning over fans with his playful yet determined spirit. As the community rallies behind him, Al's rise to victory seems inevitable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unmadesugar_a_alpaca_in_the_sea_in_a_snorkel_28697ac3_fc61_43b1_8046_01c0595a6369_5bc67ec92e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

