module 0xdad04712e2e5e5a33e63e687193b226912da1629eb88636c744330641a0c245d::bonny {
    struct BONNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONNY>(arg0, 6, b"BONNY", b"Bony On Sui", b"BONY is no ordinary dog, cute but strong, intelligent and persistent, he roams the vast plains with noble goals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006563_40cd802e35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

