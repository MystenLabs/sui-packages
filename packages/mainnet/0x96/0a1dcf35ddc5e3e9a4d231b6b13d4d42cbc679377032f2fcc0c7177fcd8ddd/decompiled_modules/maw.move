module 0x960a1dcf35ddc5e3e9a4d231b6b13d4d42cbc679377032f2fcc0c7177fcd8ddd::maw {
    struct MAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAW>(arg0, 6, b"MAW", b"SUIMWAW", b"Kittens are tiny bundles of fur and curiosity, with playful paws and the sweetest purrs. They chase shadows, tumble over nothing, and melt hearts with just one look. Every nap is an adventure in dreaming, and every little meow is a call for love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ai_generated_9058453_1280_d66fe59269.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

