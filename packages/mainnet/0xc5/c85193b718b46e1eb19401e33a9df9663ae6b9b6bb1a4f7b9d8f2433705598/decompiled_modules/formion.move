module 0xc5c85193b718b46e1eb19401e33a9df9663ae6b9b6bb1a4f7b9d8f2433705598::formion {
    struct FORMION has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORMION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORMION>(arg0, 9, b"FORMION", b"FOM", b"Formion is an advanced crypto trading platform powered by AI tools and bots. It provides real-time market analysis, precise price predictions, and automated strategies, helping users trade smarter and achieve better results. With its AI-driven insights, Formion simplifies complex trading decisions and ensures users stay ahead in the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://formion.ai/logo/fomlogo.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FORMION>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORMION>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FORMION>>(v2);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

