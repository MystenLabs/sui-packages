module 0xff1c9534d0ead35c20a8e11c635c25df6bbaa08f74c520e4fabc19f68aba3bff::twench {
    struct TWENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWENCH>(arg0, 6, b"TWENCH", b"TWENCH SUI", b"A Token Designed For Those Who Hustle Day And Night, Driven By The Goal Of Financial Freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_27_0cd0840b2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

