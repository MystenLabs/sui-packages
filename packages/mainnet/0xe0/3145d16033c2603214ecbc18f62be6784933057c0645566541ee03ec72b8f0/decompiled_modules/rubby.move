module 0xe03145d16033c2603214ecbc18f62be6784933057c0645566541ee03ec72b8f0::rubby {
    struct RUBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBBY>(arg0, 9, b"RUBBY", b"Ruby Floof", x"41206375746520626f7720616e642072687974686d6963206d6f76656d656e74732e2044616e63652077697468206d65f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifarrhspcy5dknp3xykcig2nojzs7utqlz7kopzfpzxaz3xxlqaja.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUBBY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUBBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBBY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

