module 0x1ddc743eaa082b423c8ee94750048967123e5776452a2158c591c36083c40697::wld {
    struct WLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLD>(arg0, 6, b"WLD", b"World Liberty DOGE", b"World Liberty Doge is the ultimate mix of freedom and memes! A golden-winged Doge bringing \"yuge\" energy and endless fun. The true mascot combining everyones favorite Shiba Inu with big ambitions. Much wow, very liberty!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wordl_Liberty_Doge_703598ebb5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

