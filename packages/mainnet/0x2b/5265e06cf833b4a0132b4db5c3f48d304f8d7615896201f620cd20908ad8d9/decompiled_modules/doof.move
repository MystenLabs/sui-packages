module 0x2b5265e06cf833b4a0132b4db5c3f48d304f8d7615896201f620cd20908ad8d9::doof {
    struct DOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOF>(arg0, 6, b"DOOF", b"Doof the Duck", x"446f6f66206973206120636c75656c65737320646567656e206475636b2077697468207a65726f20706c616e7320616e64206d6178696d756d206368616f732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dooftheducklogo_b93831786a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

