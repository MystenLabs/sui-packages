module 0xeb8b57d73dd20243baed1f8710739dd8b4e88dbfadfe1e356b438e516e4daf14::swoop {
    struct SWOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOP>(arg0, 9, b"SWOOP", b"Swoop on SUI", b"Woop Woop Woop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmYGcjMQEVqv5DnLNKKH4gYuLi457vheuadKYpgbFhCN4a"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWOOP>>(v1);
        0x2::coin::mint_and_transfer<SWOOP>(&mut v2, 1000000000000000000, @0xe04d741ff01faa47c3bc0a27d618a64205f50d0cb6fd7bd946d7bef25928e44f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SWOOP>>(v2);
    }

    // decompiled from Move bytecode v6
}

