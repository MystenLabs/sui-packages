module 0x488f384aab6d49512b366a783a0c31a600f06d4310f89e30a3f6f9720e9fa8df::slinky {
    struct SLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLINKY>(arg0, 9, b"SLINKY", b"Slinky", b"Slinky: The First Compressed Token to Airdrop All of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/jjrj9Yc.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLINKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLINKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLINKY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

