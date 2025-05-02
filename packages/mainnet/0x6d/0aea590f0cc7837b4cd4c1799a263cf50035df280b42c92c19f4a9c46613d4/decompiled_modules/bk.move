module 0x6d0aea590f0cc7837b4cd4c1799a263cf50035df280b42c92c19f4a9c46613d4::bk {
    struct BK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BK>(arg0, 9, b"BK", b"BKAP", b"100% guarantee Meme Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/75fff01c7014a332e0f7a4c43f1be429blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

