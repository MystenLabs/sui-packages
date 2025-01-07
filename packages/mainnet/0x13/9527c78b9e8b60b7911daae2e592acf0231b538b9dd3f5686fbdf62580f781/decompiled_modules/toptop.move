module 0x139527c78b9e8b60b7911daae2e592acf0231b538b9dd3f5686fbdf62580f781::toptop {
    struct TOPTOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPTOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPTOP>(arg0, 9, b"TOPTOP", b"tip", b"tip top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibraezek523rhmoleexpt42kla5hyf6ntzxmnzc5nj2x55f6gbbx4.ipfs.dweb.link/Clonkbot%20SUI.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOPTOP>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPTOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOPTOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

