module 0x12a3ddf16a63cbe7afbe3d643dcc1b172fda2e1fb3bd8cf72b1e540fd36f3665::bit {
    struct BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BIT>(arg0, 6, b"BIT", b"Bitcoin120k by SuiAI", b"Vamos comemorar os 120k do bictcoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6837_f5ee86877b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

