module 0xb91d55ea1d5e272ab4543f76b29d339d5efd8536dbef8dbbfeadc4c8d5a7b57b::wupe {
    struct WUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUPE>(arg0, 6, b"WUPE", b"WUKONG PEPE", b"Combines the legendary power of the Monkey King with the Meme Character Namely $PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_11_04_20_20_f8a47ff6ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

