module 0xc7f0f69bde358cdcc34e1e513d7547d2ca69aaad5256983fd23f46fc6da358f8::octopass {
    struct OCTOPASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPASS>(arg0, 6, b"Octopass", b"Octopas", x"4f63746f7061737320697320636f6d696e6720746f20537569206d61726b6574202d2041206d656d6520746f6b656e20616374696e67206c696b652061206d656d6520746f6b656e2e0a776520617265206c61756e6368696e6720617420547572626f732046756e2e200a41726520796f75207265616479203f3f3f3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964475585.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOPASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

