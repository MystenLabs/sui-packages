module 0x7c411bd430dcf09075cd059e02a28ed4f1acd87c131d9ebb695f4c67ce10bb43::bbhippo {
    struct BBHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBHIPPO>(arg0, 6, b"BBHIPPO", b"Baby Hippo Sui", b"Baby Hippo is a memecoin based on the Sui blockchain, inspired by the famous pygmy hippopotamus named Moo Deng, born on July 10, 2024 at Khao Kheow Zoo in Thailand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_041644_563_abc4646fab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

