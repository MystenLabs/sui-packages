module 0xb785ce8cae5a96659181e42f9534be093c71ace08af4e41a3db1969cd5f53054::cannabis {
    struct CANNABIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANNABIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANNABIS>(arg0, 9, b"CANNABIS", b"CANNABIS", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CANNABIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANNABIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANNABIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

