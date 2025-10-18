module 0xd2c949428a4b5e0a15e59079bec85f8e4b6370008aba2879de6ae6c49e91fc80::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 9, b"TEST3", b"test3", b"test  with image", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/drive/folders/13RA7wNJYgmuZjCuv2X3t3akmKWjKAcvw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST3>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST3>>(v2, @0xfd8e97e7b0b9aebf40623b67e60f25952af6af1658b777b1fc4d50b79298a143);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST3>>(v1);
    }

    // decompiled from Move bytecode v6
}

