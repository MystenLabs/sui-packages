module 0xf3ccf30f08ec934c6e6c5322fa23bfd374adc695642c68384320575b785ded99::jay {
    struct JAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAY>(arg0, 6, b"JAY", b"jay.ai", b"Jay.ai is a decentralized experiment on the SUI blockchain, combining blockchain technology, artificial intelligence, and DAO, aspiring to become the first fan AI meme merged by the Artificial Superintelligence Alliance (ASI)!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015718_369da8011e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

