module 0x69fd93479c3d3ac030946e00920855af6d02ee875905e71dedd87226bf0d8100::MYLO {
    struct MYLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYLO>(arg0, 9, b"MYLO", b"Mylo", b"$MYLO son of $MYRO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746620792568193024/aYzK3nR3_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

