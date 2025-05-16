module 0xceb6fc34fca626955da9536fa918db863d0cd4d3e5e2e6cd099f20ba7f706c7a::popeye {
    struct POPEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEYE>(arg0, 6, b"POPEYE", b"Popeye On Sui", x"506f7065796520546865205375696c6f726d616e2c206973206d6f7265207468616e206a75737420616e2061646f7261626c65206d6173636f742e0a6974277320612063756c7475726520636f696e207468617420697320612073796d626f6c206f6620696e6e6f766174696f6e20696e207468652063727970746f207370616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicpwcr6eve6mdona54trkxvq6ygtajzxmam63xa3hsnult3id6irm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPEYE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

