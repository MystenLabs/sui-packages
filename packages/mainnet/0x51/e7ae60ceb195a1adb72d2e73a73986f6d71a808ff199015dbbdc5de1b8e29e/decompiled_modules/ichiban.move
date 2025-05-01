module 0x51e7ae60ceb195a1adb72d2e73a73986f6d71a808ff199015dbbdc5de1b8e29e::ichiban {
    struct ICHIBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICHIBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICHIBAN>(arg0, 6, b"ICHIBAN", b"Ichiban Sui", b"ICHIBAN -  is a Star Atlas Community Meme coin powered by the people for the people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ichiban_Sushi_Artboard_402_92c498ce08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICHIBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICHIBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

