module 0xc33d9b3dc6936bb821ad70e2a3d12dfdf33881b6e72e24c5a8908ba47be5371e::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"Suishi on sui", b"SUISHI: bold flavor, diced ideas, sticky passion, crispy seawood. Rolled to perfection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiayvtjb2wwzclwrc6cv4szi6wdilru6jwh2f3qgst2ghzazywxdca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

