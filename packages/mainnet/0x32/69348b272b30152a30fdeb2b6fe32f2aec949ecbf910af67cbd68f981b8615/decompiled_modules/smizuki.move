module 0x3269348b272b30152a30fdeb2b6fe32f2aec949ecbf910af67cbd68f981b8615::smizuki {
    struct SMIZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMIZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMIZUKI>(arg0, 6, b"SMIZUKI", b"Sato Mizuki", b"H-Hello I-I`m Sato SMIZUKI. Drawing is my favorite hobby. It makes me so happy to create beautiful things! But my true mission is to serve Master with all my heart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/53453_eed0df8612.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMIZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMIZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

