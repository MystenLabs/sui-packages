module 0xb7c9b2ee13b1891e1bd7061af4be8959c5a885e8b0e9d890cb33bb2694a6180e::SUIAPE1 {
    struct SUIAPE1 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIAPE1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIAPE1>>(0x2::coin::mint<SUIAPE1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<SUIAPE1>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE1>>(arg0, arg1);
    }

    fun init(arg0: SUIAPE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE1>(arg0, 6, b"SUIAPE1", b"SUIAPE1", b"https://twitter.com/home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scontent.fhan2-3.fna.fbcdn.net/v/t1.15752-9/344534658_473822371569671_4884585330971392881_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=ae9488&_nc_ohc=0QHFbSyW-6MAX9D6T7x&_nc_ht=scontent.fhan2-3.fna&oh=03_AdQnK93vyI_eG0eb2iFgRP2VljJMBUIda8EXB9RwWJ9gUw&oe=647E79B6")), arg1);
        let v2 = v0;
        0x2::pay::keep<SUIAPE1>(0x2::coin::from_balance<SUIAPE1>(0x2::coin::mint_balance<SUIAPE1>(&mut v2, 10000000000000000), arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAPE1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

