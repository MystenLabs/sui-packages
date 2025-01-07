module 0x9e87fdfcfd8269af3de9b24ad7a1df051984ef2b483e57f6238fb427255253c5::ocpa {
    struct OCPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCPA>(arg0, 6, b"OCPA", b"Octopass", x"4f63746f7061737320697320636f6d696e6720746f20537569206d61726b6574202d2041206d656d6520746f6b656e20616374696e67206c696b652061206d656d6520746f6b656e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731684077402.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

