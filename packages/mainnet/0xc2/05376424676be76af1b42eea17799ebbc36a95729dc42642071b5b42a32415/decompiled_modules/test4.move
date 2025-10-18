module 0xc205376424676be76af1b42eea17799ebbc36a95729dc42642071b5b42a32415::test4 {
    struct TEST4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST4>(arg0, 9, b"TEST4", b"test4", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/Suihotdog/photo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST4>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST4>>(v2, @0xfd8e97e7b0b9aebf40623b67e60f25952af6af1658b777b1fc4d50b79298a143);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST4>>(v1);
    }

    // decompiled from Move bytecode v6
}

