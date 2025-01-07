module 0xb2c47e288b9d11b97023c08cdd22cd84d7e02ddef111aa7cc24639e78a3b43b5::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"Disco Panda", b"In a digital bamboo forest on the SUI blockchain, Disco Panda was born coding by day, groovin' by night! Tired of boring crypto, he created $PANDA, the grooviest meme coin that makes every transaction a dance party. With lightning-fast moves thanks to SUI, $PANDA zooms through wallets, leaving glitter and funky beats behind. Forget the moonDisco Pandas taking you to the dance floor. Buy $PANDA, and lets boogie! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/panda_Large_0c8ffdb830.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

