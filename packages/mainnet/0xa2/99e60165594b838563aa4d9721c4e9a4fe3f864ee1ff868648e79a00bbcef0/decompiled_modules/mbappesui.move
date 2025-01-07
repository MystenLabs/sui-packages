module 0xa299e60165594b838563aa4d9721c4e9a4fe3f864ee1ff868648e79a00bbcef0::mbappesui {
    struct MBAPPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBAPPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBAPPESUI>(arg0, 9, b"MBAPPESUI", b"Mbappe Sui", b"Off token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MBAPPESUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBAPPESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBAPPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

