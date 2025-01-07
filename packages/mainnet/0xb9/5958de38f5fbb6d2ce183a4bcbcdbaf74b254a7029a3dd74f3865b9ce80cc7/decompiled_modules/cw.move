module 0xb95958de38f5fbb6d2ce183a4bcbcdbaf74b254a7029a3dd74f3865b9ce80cc7::cw {
    struct CW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CW>(arg0, 6, b"CW", b"Cheeseball  Wizard ", b"Cheese Ball the Wizard Cat rose to fame on TikTok as an icon of humor and feline magic. Now, his legend continues with $CW. Join us and experience the magic. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735973158992.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

