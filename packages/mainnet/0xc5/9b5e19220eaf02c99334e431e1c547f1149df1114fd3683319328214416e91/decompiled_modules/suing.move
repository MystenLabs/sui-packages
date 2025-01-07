module 0xc59b5e19220eaf02c99334e431e1c547f1149df1114fd3683319328214416e91::suing {
    struct SUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUING>(arg0, 6, b"SUING", b"Suingularity", b"Suingularity  - is a Community Meme Token created to describe in  one word the Power and Strength of SUI Network in this Crypto Universe. SUI chain is by far the fastest and cheapest chain as well as very friendly to all its users. All these properties will make SUI to be the Biggest Crypto in the near Future. This is just an experiment. No devs, no rug, no bs. The creator invested just 10 SUI and will not going to sell his tokens until the project reaches 1 Bln$ MC. All users are kindly invited to participate in this community event, to build this project together (Website, Twitter, Tgm ). I hope Sui will thrive and Suingularity will become Nr.1 Meme token on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suingularity_3_1ecfa973e5.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUING>>(v1);
    }

    // decompiled from Move bytecode v6
}

