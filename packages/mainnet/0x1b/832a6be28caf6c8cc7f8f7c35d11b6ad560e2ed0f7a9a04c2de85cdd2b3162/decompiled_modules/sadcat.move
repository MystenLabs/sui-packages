module 0x1b832a6be28caf6c8cc7f8f7c35d11b6ad560e2ed0f7a9a04c2de85cdd2b3162::sadcat {
    struct SADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADCAT>(arg0, 6, b"SADCAT", b"SadCat", b"The cat is sad. But rich!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/19_b80f1fc7d4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

