module 0xeaf82023dc70d0a92db1282024f1ffd62ab15bf2e50c2fd049d9edbabd66ad33::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMO>(arg0, 9, b"KUMO", b"Kumo The Cat", b"A clumsy cat has entered the chat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/Kumo_TheCat/photo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KUMO>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

