module 0xf51caae283bb5b87a7bf21447119cbb97f9e3b54c863e38edbdb9ad3000ace9f::spn {
    struct SPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPN>(arg0, 6, b"SPN", b"SUI PER NOVA", b"A collection of explosive ,high quality memes celebrating Suis breakthrough moments and rapid growth in the blockchain world . Just like a superNova, Sui shines brighter and leaves a lasting impact, blazing trails in speed, innovation and community strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1730573582457_01e217ad2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

