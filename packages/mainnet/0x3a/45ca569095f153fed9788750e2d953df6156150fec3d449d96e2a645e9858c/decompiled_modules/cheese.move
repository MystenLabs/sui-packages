module 0x3a45ca569095f153fed9788750e2d953df6156150fec3d449d96e2a645e9858c::cheese {
    struct CHEESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEESE>(arg0, 6, b"Cheese", b"SuiCheese", b"SuiCheese is a fun new meme coin on the Sui blockchain, featuring a cool mouse mascot. It represents creativity and community spirit, powered by the fast and efficient Sui network. Join the SuiCheese community and take a bite out of the blockchain world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fu_HE_Yf4a_UA_Ati_Ys_25967dab73.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

