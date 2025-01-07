module 0x703af85a6892a7ec101d178066f3c80c757915f2679a4186b3d6ca64abb15107::lap {
    struct LAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAP>(arg0, 6, b"LAP", b"Like A Fish", b"Just like a fish swimming in a sea full of whales, trying to make a splash in the meme coin market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732889065620.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

