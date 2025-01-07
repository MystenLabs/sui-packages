module 0x983cc8e9fc18b455ff98291f1fce9bcb384345b80c869ae336dd68455e217ed::dogswifs {
    struct DOGSWIFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSWIFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSWIFS>(arg0, 6, b"DOGSWIFS", b"dogs", b"Woof, woof! This meme coin is ruff-tastic! SUI Doggo brings the fun of dogs to the world of crypto on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_ud5ndmud5ndmud5n_eb47573d90.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSWIFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSWIFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

