module 0xcf4183542112fd4fa1204b9598db7964c6fc11d55207f433f787c278c7bf2fc6::baxol {
    struct BAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAXOL>(arg0, 6, b"BAXOL", b"BABY AXOL", b"Baby Axol is a fun and adorable memecoin inspired by the quirky amphibian thats known for its ability to regenerate and bring joy. Built on the Sui Network, Baby Axol is not just another coin  its a symbol of resilience, cuteness, and community. Baby Axol aims to spread positivity and build a strong, supportive ecosystem for all crypto meme enthusiasts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_175419_957_cb1c48cfc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

