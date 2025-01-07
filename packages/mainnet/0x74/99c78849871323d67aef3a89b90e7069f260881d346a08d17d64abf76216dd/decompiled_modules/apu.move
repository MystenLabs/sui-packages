module 0x7499c78849871323d67aef3a89b90e7069f260881d346a08d17d64abf76216dd::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 6, b"APU", b"Apo on Sui", x"546865203173742024415055206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_7be6162307.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APU>>(v1);
    }

    // decompiled from Move bytecode v6
}

