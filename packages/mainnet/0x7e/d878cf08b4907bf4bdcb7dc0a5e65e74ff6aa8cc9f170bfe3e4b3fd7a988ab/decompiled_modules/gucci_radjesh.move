module 0x7ed878cf08b4907bf4bdcb7dc0a5e65e74ff6aa8cc9f170bfe3e4b3fd7a988ab::gucci_radjesh {
    struct GUCCI_RADJESH has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUCCI_RADJESH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJESH>>(0x2::coin::mint<GUCCI_RADJESH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GUCCI_RADJESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUCCI_RADJESH>(arg0, 9, b"RADJA", b"GUCCI RADJESH", x"4755434349205241444a45534820e28093204472697020536f20486172642c204576656e20596f75722057616c6c657420466c6578657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/tTSBSJqS/Gen-3-Alpha-Turbo1095981416-Cropped-GUCCI-RADJM5-ezgif-com-video-to-gif-converter.gif")), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<GUCCI_RADJESH>(&mut v2, 1500000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJESH>>(0x2::coin::split<GUCCI_RADJESH>(&mut v3, 1000000000000000000, arg1), @0x9752d337036cfbb6a91dae286ad3840a419475ea0e8162ab3a39b888ddd8931);
        let v4 = 250000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJESH>>(0x2::coin::split<GUCCI_RADJESH>(&mut v3, v4, arg1), @0xe2f6e1d10584c74264e84f3bd4faa9d0139e194d38216c0e807723441240d167);
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJESH>>(0x2::coin::split<GUCCI_RADJESH>(&mut v3, v4, arg1), @0x9068681c94d578cc4fe28b23149c4ee996fcdde6111183e60e072bdfdd37bfd7);
        if (0x2::coin::value<GUCCI_RADJESH>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJESH>>(v3, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<GUCCI_RADJESH>(v3);
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUCCI_RADJESH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUCCI_RADJESH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

