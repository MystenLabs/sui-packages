module 0x14d8a51f6283bba7b5c3757e4563bfdaa3aed63fd3536804bbc33159244309d::octofun {
    struct OCTOFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOFUN>(arg0, 6, b"OCTOFUN", b"Octopass", x"4e6f77207765277265206c697665206f6e20547572626f732e0a4f63746f7061737320697320636f6d696e6720746f20537569206d61726b6574202d2041206d656d6520746f6b656e20616374696e67206c696b652061206d656d6520746f6b656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963554713.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

