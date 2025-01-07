module 0xda245e31245d2b5630a21f740f942d9021eb291d73062d927a0c6b34350a12ac::hyrax {
    struct HYRAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYRAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYRAX>(arg0, 6, b"HyraX", b"Kappashan", x"4879726178206973206e6f74206a7573742061206d656d6520636f696e3b206974732061206d6f76656d656e742e204469766520696e746f206120776f726c642077686572652068756d6f72206d6565747320696e6e6f766174696f6e2c20616e642062652070617274206f66206120636f6d6d756e69747920746861747320726573686170696e67207468652063727970746f206c616e64736361706521210a0a537461792074756e656420666f7220667574757265207570646174657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kappa_ba40430c0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYRAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYRAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

