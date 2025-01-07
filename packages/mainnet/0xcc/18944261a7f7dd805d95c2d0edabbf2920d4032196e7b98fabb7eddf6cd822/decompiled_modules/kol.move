module 0xcc18944261a7f7dd805d95c2d0edabbf2920d4032196e7b98fabb7eddf6cd822::kol {
    struct KOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOL>(arg0, 6, b"KOL", b"KeyofLifeAI", x"f09f9a80204b6579206f66204c6966653a2054686520537569204e6574776f726be2809973203173742041492d706f77657265642073746f7265206f662076616c756520746f6b656e2e20f09f92a10af09f92b820576174636820796f7572206d6f6e6579206175746f2d67726f7720776974682065766572792074726164652e205061737369766520696e636f6d65206d61646520736d61727465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736226609330.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

