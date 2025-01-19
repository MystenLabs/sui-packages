module 0x23737d3d424c4836187b0896f0c09494268db27a6fa33b8455e151a37984f6ce::boob {
    struct BOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOB>(arg0, 9, b"BOOB", b"BOOB", b"All about boobs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallhere.com/en/wallpaper/1348035")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOB>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

