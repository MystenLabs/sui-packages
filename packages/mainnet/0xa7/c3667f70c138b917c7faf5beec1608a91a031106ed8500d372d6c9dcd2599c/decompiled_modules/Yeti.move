module 0xa7c3667f70c138b917c7faf5beec1608a91a031106ed8500d372d6c9dcd2599c::Yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YETI>, arg1: 0x2::coin::Coin<YETI>) {
        0x2::coin::burn<YETI>(arg0, arg1);
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 2, b"YETI", b"YETI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/7RTbOmq.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YETI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YETI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YETI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

