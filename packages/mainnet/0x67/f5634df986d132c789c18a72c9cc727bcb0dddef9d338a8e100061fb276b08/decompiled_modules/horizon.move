module 0x67f5634df986d132c789c18a72c9cc727bcb0dddef9d338a8e100061fb276b08::horizon {
    struct HORIZON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORIZON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORIZON>(arg0, 9, b"HORIZON", b"Horizon on Sui", b"Horizon AI is an AI-powered platform designed to simplify data analysis, automate tasks, and enhance decision-making. It offers smart and user-friendly tools to help businesses and individuals work more efficiently and effectively.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeJAR9ubYFQJ4btSV4BjCDuiWABhWWUnqUefUrnU5p7SP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HORIZON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORIZON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORIZON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

