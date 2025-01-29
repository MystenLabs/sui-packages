module 0xb433c784dc32e33244711af8f4ec6b46c2ee1aa2e150de4439d8d6080e8ad2bb::brainy {
    struct BRAINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINY>(arg0, 9, b"BRAINY", b"Brainy On Sui", x"546865206e657874206269672054696b546f6b206d656d6520737461722068617320616c726561647920626567756e207468656972206a6f75726e65792e0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcndRhnSg7UyiYRZGyRVd74XUwYt94K58YZy18MxcgJgG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRAINY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAINY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

