module 0x98865bcab5abe3acc64611a5ed1d1199eed341965ba9e83ce68f587161f212b4::SUIAPE {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIAPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIAPE>>(0x2::coin::mint<SUIAPE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<SUIAPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(arg0, arg1);
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 6, b"SUIAPE", b"SUIAPE", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scontent.fhan2-3.fna.fbcdn.net/v/t1.15752-9/344534658_473822371569671_4884585330971392881_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=ae9488&_nc_ohc=0QHFbSyW-6MAX9D6T7x&_nc_ht=scontent.fhan2-3.fna&oh=03_AdQnK93vyI_eG0eb2iFgRP2VljJMBUIda8EXB9RwWJ9gUw&oe=647E79B6")), arg1);
        let v2 = v0;
        0x2::pay::keep<SUIAPE>(0x2::coin::from_balance<SUIAPE>(0x2::coin::mint_balance<SUIAPE>(&mut v2, 10000000000000000), arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

