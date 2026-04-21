module 0x55fc2f88b7ae10c49229563946be31c90eb0ffb5c00b0434fe6c2e0bce0e92ab::funny_kat {
    struct FUNNY_KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY_KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY_KAT>(arg0, 9, b"KAT", b"Funny KAT", b"funny cat coin on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776786213030-3e32f06ed612c6bc48b6a94bdc1d50b3.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FUNNY_KAT>>(0x2::coin::mint<FUNNY_KAT>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNY_KAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY_KAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

