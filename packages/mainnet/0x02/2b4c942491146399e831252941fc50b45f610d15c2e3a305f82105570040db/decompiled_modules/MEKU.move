module 0x22b4c942491146399e831252941fc50b45f610d15c2e3a305f82105570040db::MEKU {
    struct MEKU has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEKU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<MEKU>(arg0) + arg1 <= 1000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEKU>>(0x2::coin::mint<MEKU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MEKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKU>(arg0, 6, b"MEKU", b"MEKU", b"MEKU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/meld.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MEKU>>(0x2::coin::mint<MEKU>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKU>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

