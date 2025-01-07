module 0x6000691a2e3bb1b1010c03b6c6734ecadc98d8d4a04f5a2339bcb4f8d2c153a::suifur {
    struct SUIFUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUR>(arg0, 6, b"SUIFUR", b"Suifur", b"In the wild world of crypto, where innovation meets meme culture, SUIFUR ignites a new spark. Named after sulfur, the fiery element known for both destruction and transformation, SUIFUR is here to disrupt the Sui Network with its explosive energy. Just like sulfur powers volcanic eruptions, SUIFUR is ready to fuel a financial revolution. Whether you're a savvy trader or just in it for the memes, SUIFUR promises both fun and potential gains in the volatile and thrilling space of meme-based cryptocurrencies. Get ready for a combustible ride to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/periodic_table_element_sulfur_vector_24960013asdasdas_1562d78bfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

