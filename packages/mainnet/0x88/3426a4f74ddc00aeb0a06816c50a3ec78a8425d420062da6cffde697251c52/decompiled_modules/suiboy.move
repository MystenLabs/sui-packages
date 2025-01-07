module 0x883426a4f74ddc00aeb0a06816c50a3ec78a8425d420062da6cffde697251c52::suiboy {
    struct SUIBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOY>(arg0, 9, b"SUIBOY", b"SuiBOY", b"sui boy!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBOY>(&mut v2, 1500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

