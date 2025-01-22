module 0x2599f256007b1a8de627dcfc994360ab0edbe72358bf6b08477734cf69487721::anaai {
    struct ANAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANAAI>(arg0, 9, b"ANAAI", b"ANA AI ", b"ANA AI On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme4yuXyhg21Ufms8h3rRDPRvW2yfRG1Et7Xw9uMtN6g45")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANAAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANAAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

