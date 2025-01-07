module 0xdda0b6ca35081d8ec7efcc93b288f7116428c4690772935e365dc08f5f2c9567::bbj {
    struct BBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBJ>(arg0, 6, b"BBJ", b"Beetlejuice JNR", b"Welcome to Beetlejuice JNR ($BJJ), the mischievous and long-forgotten son of the original Beetlejuice, rising from the underworld to make his mark on the crypto universe. Abandoned by his father in the shadowy corridors of the afterlife, Beetlejuice JNR is back with a vengeance, fueled by a chaotic mix of dark humor and supernatural powers. His goal? To haunt the meme-token realm, wreak havoc in the most entertaining way possible, and prove once and for all that the next generation of Beetlejuice is not to be ignored. The $BJJ token is more than just a memeit's a rebellion against the ordinary, a playful nod to the spirit of Halloween, and a spooky journey into the unknown, where the weird is celebrated and the profits are out of this world. The legend of Beetlejuice JNR began in the shadows of the underworld. Forgotten by his father, the notorious Beetlejuice, young JNR grew up amidst the spirits and ghouls, plotting his rise to power. No longer content with just being a footnote in the dark tale of his father, Beetlejuice JNR has decided to channel his pent-up energy into the cryptoverse, creating his own path as the leader of a meme rebellion. But Beetlejuice JNR isnt just out to make a jokehe has a purpose. The world of crypto is his playground, and hes determined to make $BJJ the meme token that thrives in the most unexpected ways. Channeling his father's cunning and adding his own twist of gothic charm, Beetlejuice JNR is here to give the meme token community a serious scarewith laughter and profits. Every holder of $BJJ becomes part of this twisted adventure, where holding onto tokens means joining the underworld elite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Eszqaw1_SW_3x3_K_Mo_V9v_ZRP_Xtq_HR_Lu_CM_6q1_W9uk_RD_3_Ry3_0dcc63998b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

