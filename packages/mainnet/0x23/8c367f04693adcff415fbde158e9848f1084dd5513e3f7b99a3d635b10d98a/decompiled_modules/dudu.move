module 0x238c367f04693adcff415fbde158e9848f1084dd5513e3f7b99a3d635b10d98a::dudu {
    struct DUDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDU>(arg0, 6, b"DUDU", b"Dudu the Dragon Thief of Sui's", b"Dudu the Dragon Thief of Sui's is the legendary, fire-breathing rogue of the Sui blockchain! Known for swooping in and snatching up rare tokens and hidden treasures, Dudu navigates the digital skies with unmatched stealth and speed. This crafty dragon doesnt just hoard goldhe's after the most elusive crypto gems. With scales of steel and a heart full of mischief, Dudu rules the blockchain underworld, leaving a trail of smoke and mystery in his wake.  #DragonThief #CryptoHeist #SuiLegend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sem_t_A_tulodawdawd_78f59a6113.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

