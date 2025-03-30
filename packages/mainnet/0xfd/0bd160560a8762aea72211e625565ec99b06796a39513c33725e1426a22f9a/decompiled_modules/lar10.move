module 0xfd0bd160560a8762aea72211e625565ec99b06796a39513c33725e1426a22f9a::lar10 {
    struct LAR10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAR10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAR10>(arg0, 9, b"Lar10", b"laryyy", b"it's a meme created for this campaign", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/24cff3f206ba975de29ef8d5a7512dd8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAR10>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAR10>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

