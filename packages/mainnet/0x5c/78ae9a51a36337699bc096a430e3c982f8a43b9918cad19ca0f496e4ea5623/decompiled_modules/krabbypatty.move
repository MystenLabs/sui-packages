module 0x5c78ae9a51a36337699bc096a430e3c982f8a43b9918cad19ca0f496e4ea5623::krabbypatty {
    struct KRABBYPATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABBYPATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABBYPATTY>(arg0, 6, b"KRABBYPATTY", b"Krabby Patty", b"Introducing Krabby Patty, the latest token to make waves on the SUI Blockchain. Inspired by the beloved underwater icon, Krabby patty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_18_at_07_49_26_f9748553fa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABBYPATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABBYPATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

