module 0x9ec7fe865af5961cbdcfd42863e4b8ac03040958d051c955483ced47c843a3b1::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 6, b"SPC", b"SUI LOVER", b"Spreading love and compassion to everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidbmxw7xbx6c6dv2n4ascxjurdk6rpqj2tt3iduk62gpacixs27za")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

