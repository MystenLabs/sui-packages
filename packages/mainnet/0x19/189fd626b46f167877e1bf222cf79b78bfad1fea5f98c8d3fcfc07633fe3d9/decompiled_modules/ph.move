module 0x19189fd626b46f167877e1bf222cf79b78bfad1fea5f98c8d3fcfc07633fe3d9::ph {
    struct PH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PH>(arg0, 9, b"PH", b"PondHub by Virtuals", b"PondHub by Virtuals token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeigohkfkrm7wjiuw3kgdua3c2b4p46rrgibtz2notdrnhfran6refm.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

