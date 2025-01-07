module 0xd3c10e64898b68767309f1f231a76a95226cd0a8aa38253d028994c0fe9281e8::myst {
    struct MYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYST>(arg0, 6, b"MYST", b"Mysterious Coin", b"Born from the shadows, shrouded in enigma. No website. No Twitter. Just whispers in the void and the thrill of the unknown. Those who hold it become part of a secret no one can explain but all will seek. The rest will only wonder. And its value? No one will ever truly know.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_test_01edbc93ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYST>>(v1);
    }

    // decompiled from Move bytecode v6
}

