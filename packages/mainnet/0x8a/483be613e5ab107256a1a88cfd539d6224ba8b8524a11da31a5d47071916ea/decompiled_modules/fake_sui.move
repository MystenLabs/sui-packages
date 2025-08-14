module 0x8a483be613e5ab107256a1a88cfd539d6224ba8b8524a11da31a5d47071916ea::fake_sui {
    struct FAKE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[b"FAKE_SUI", b"Fake SUI", b"Just a fake sui coin", b"https://memez.gg"];
        let v1 = vector[b"FAKE_SUI", b"Fake SUI", b"Just a fake sui coin", b"https://memez.gg"];
        let v2 = vector[b"FAKE_SUI", b"Fake SUI", b"Just a fake sui coin", b"https://memez.gg"];
        let v3 = vector[b"FAKE_SUI", b"Fake SUI", b"Just a fake sui coin", b"https://memez.gg"];
        let (v4, v5) = 0x2::coin::create_currency<FAKE_SUI>(arg0, 9, *0x1::vector::borrow<vector<u8>>(&v0, 0), *0x1::vector::borrow<vector<u8>>(&v1, 1), *0x1::vector::borrow<vector<u8>>(&v2, 2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v3, 3))), arg1);
        let v6 = v4;
        0x2::coin::mint_and_transfer<FAKE_SUI>(&mut v6, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_SUI>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAKE_SUI>>(v5);
    }

    // decompiled from Move bytecode v6
}

