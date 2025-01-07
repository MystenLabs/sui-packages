module 0xbef3a483f73ae7b4bd1c609e2f45723b76ebee4a781c5f70259145b0ad83e49::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 9, b"SUICAT", b"Sui Cat", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.shutterstock.com/image-vector/cute-lucky-cat-gold-coin-260nw-2341874261.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

