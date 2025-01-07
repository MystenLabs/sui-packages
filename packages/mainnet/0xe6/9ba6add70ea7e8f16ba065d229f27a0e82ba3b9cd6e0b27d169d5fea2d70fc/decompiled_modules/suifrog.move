module 0xe69ba6add70ea7e8f16ba065d229f27a0e82ba3b9cd6e0b27d169d5fea2d70fc::suifrog {
    struct SUIFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFROG>(arg0, 6, b"SUIFROG", b"GRAZY  FROG", b"Musk inspired to decentralized token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008961_8f857ec8cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

