module 0x2ba0b6d3e37ebb7da2737e88ab850194f4e2659dd2bc7f1911de100299953252::raven {
    struct RAVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAVEN>(arg0, 6, b"RAVEN", b"RAVEN ON SUI", b"We come here to fly with the hype of sui network and the voice of raven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihi74lkvs3ht7c5dsiexfyyzsnflt2ixxr6cwhwvo733mmbhgamwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAVEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

