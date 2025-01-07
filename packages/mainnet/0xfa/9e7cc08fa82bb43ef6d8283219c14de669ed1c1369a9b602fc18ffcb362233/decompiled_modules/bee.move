module 0xfa9e7cc08fa82bb43ef6d8283219c14de669ed1c1369a9b602fc18ffcb362233::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"SUIBEE", b"SUIBEE, also known as $BEE, is a meme token within the Sui blockchain ecosystem. It symbolizes the fusion of \"honey\" and Sui's \"drops,\" aiming to create a unique blend that drives the token to new heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951174647.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

