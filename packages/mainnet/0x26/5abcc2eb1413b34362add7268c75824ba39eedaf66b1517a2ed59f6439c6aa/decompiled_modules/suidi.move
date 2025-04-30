module 0x265abcc2eb1413b34362add7268c75824ba39eedaf66b1517a2ed59f6439c6aa::suidi {
    struct SUIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDI>(arg0, 6, b"SUIDI", b"Rise Of Suidi", x"53554944492073746172746564617320612066756e2c206368616f746963206d656d6520746f6b656e2077697468206e6f20636c65617220707572706f73652e0a4e6f772c2052697365206f66205375696469206973206f7572207365636f6e64206368616e636520206120636f6d706c6574652072656272616e6420776974682061206672657368207465616d2c20616e2061637469766520636f6d6d756e6974792c20616e642062696720647265616d732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihsnvzi2efkmr3czljfl5j6vfdgc4nv2zjvk4k3wr2wuxsst3ehmq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

