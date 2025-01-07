module 0xadc96b6804d104d2280b22477588fd000e4fb9dc202d8558e3441d1435435702::suistation {
    struct SUISTATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTATION>(arg0, 6, b"SUISTATION", b"SuiStation", b"$SUISTATION is the ultimate crossover token that fuses the nostalgia of gaming with the cutting-edge blockchain technology of the SUI network. Imagine the iconic energy of the PlayStation universe, now reimagined in a decentralized world where gamers and crypto enthusiasts unite! This token powers an ecosystem where players can trade, compete, and collect exclusive NFTs inspired by classic gaming momentsall while leveraging the speed and security of the SUI blockchain. Join the $SUISTATION revolution, where every transaction feels like unlocking a new level!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_51_31ded16dca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTATION>>(v1);
    }

    // decompiled from Move bytecode v6
}

