module 0x5c74a039d57c68de0b8e08e1a368acb1eab88bfef97cd50763d6754145dedfab::sensui {
    struct SENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSUI>(arg0, 6, b"SENSUI", b"Koro SenSui", b"$SENSUI is a meme-token that captures the essence of SUIs swift transactions, with a playful twist inspired by the legendary Koro Sensei! Just like the near-impossible-to-catch teacher from Assassination Classroom, $SENSUI zips across the blockchain with speed and cunning, outsmarting the competition with its clever moves. Whether youre a trader or a hodler, $SENSUIs mission is to bring fun, agility, and relentless growth to your crypto journey. Get ready to dodge volatility like Koro Sensei dodges attacks$SENSUI is here to make waves on the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_18_bdeb3935ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

