module 0x62fc56bada6e5e1b2fb7bf4973759705e936b374151bb6682b2d0baecccdfce9::doof {
    struct DOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOF>(arg0, 6, b"DOOF", b"DOOF the DUCK", x"446f6f66206973206120636c75656c65737320646567656e206475636b2077697468207a65726f20706c616e7320616e64206d6178696d756d206368616f732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dooftheducklogo_b3264d07bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

