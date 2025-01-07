module 0x69d6322c7b33232d1700002512ce12699538aa42c3589434dd26062b1eeccbe0::elm {
    struct ELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELM>(arg0, 6, b"ELM", b"Elon Musk", b"Elon Reeve Musk FRS (born June 28, 1971) is a businessman and investor known for his key roles in the space company SpaceX and the automotive company Tesla, Inc. Other involvements include ownership of X Corp., the company that operates the social media platform X (formerly known as Twitter), and his role in the founding of The Boring Company, xAI, Neuralink, and OpenAI. He is one of the wealthiest individuals in the world; as of August 2024 Forbes estimates his net worth to be US$247 billion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/bzj97C0/2074368931.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELM>>(v1);
    }

    // decompiled from Move bytecode v6
}

