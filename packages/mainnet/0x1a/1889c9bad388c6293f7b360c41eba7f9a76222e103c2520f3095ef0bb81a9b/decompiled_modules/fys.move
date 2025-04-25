module 0x1a1889c9bad388c6293f7b360c41eba7f9a76222e103c2520f3095ef0bb81a9b::fys {
    struct FYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYS>(arg0, 6, b"FYS", b"Fuck You Scammers", b"This is a coin of resistance against the bastard scammers, buy this coin and prove to the scammers that they are bastards!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062232_25bab0ae6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

