module 0xcac1de147a20e8e3da456b873bfd2861c5b5ab3a8178f828241c3c483c4de5cd::img {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IMG>(arg0, 6, b"IMG", b"ImageCoin by SuiAI", b"The scalable decentralized digital currency shaping the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4890dcdc_2676_437a_afff_b02625f41262_11bec32680.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

