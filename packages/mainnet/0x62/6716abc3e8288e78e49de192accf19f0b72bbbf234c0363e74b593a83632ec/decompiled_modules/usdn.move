module 0x626716abc3e8288e78e49de192accf19f0b72bbbf234c0363e74b593a83632ec::usdn {
    struct USDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDN>(arg0, 6, b"USDN", b"USDN", b"USD DIGITAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/1Ih08iqI-fJUeBXRvpH00B0WiaishMH0cbxqAzjGfu8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDN>>(v2, @0x15462a7cc618bd1e747a7b14269329ce93d2d13dc209d78444e465025a3d755e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

