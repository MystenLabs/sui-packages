module 0xb31aa7e8dba7a6052c4631779e48c36585bf2c389a9a52e03bb469ba66b06442::ai_pad {
    struct AI_PAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_PAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI_PAD>(arg0, 9, b"AI PAD", b"Ai Pad Token", b"AIPAD Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775788513953-ef7c7c00dc66646c1f38e287534f36d5.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AI_PAD>>(0x2::coin::mint<AI_PAD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI_PAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_PAD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

