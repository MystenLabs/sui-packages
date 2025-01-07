module 0xe6f1a88f37347863690163bf8c81e7e579e21ffb0ca95bd2235baac0a11a71e4::aaam {
    struct AAAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAM>(arg0, 6, b"AAAM", b"AAA Michi", b"Welcome to AAA Michi, where memes meet crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_06_T171909_234_4e1593df6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

