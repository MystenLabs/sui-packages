module 0xe3267676813ec2522730e834d144bb4a6cc7d7173899128e5571215d3116f9d0::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BABYAXOL", b"Baby axol", b"Baby Axol is a fun and adorable memecoin inspired by the quirky amphibian thats known for its ability to regenerate and bring joy. Built on the Sui Network, Baby Axol is not just another coin  its a symbol of resilience, cuteness, and community. Baby Axol aims to spread positivity and build a strong, supportive ecosystem for all crypto meme enthusiasts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3550_45ff78d2e0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

