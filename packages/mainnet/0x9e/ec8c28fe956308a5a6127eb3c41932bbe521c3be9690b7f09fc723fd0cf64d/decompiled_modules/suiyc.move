module 0x9eec8c28fe956308a5a6127eb3c41932bbe521c3be9690b7f09fc723fd0cf64d::suiyc {
    struct SUIYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYC>(arg0, 6, b"SUIYC", b"Sui Yacht Club", x"57656c636f6d6520746f2053756920596163687420436c75622c2074686520636f6f6c65737420746f6b656e206f6e2074686520537569206e6574776f726b2120496e73706972656420627920426f7265642041706527732069636f6e69632072656c6178656420766962652c2053756920596163687420436c7562206973206e6f74206a757374206120746f6b656e2c2062757420616e20696e7669746174696f6e20746f206120756e69717565206a6f75726e6579206f66206c75787572792c2066756e2c20616e64206578636c75736976697479206163726f737320746865206469676974616c20736561732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_10_07_162345_removebg_preview_1030c4d1dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

