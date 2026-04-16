module 0x9f48b4b40505f587a6aaa895c26f200587f8ae1a994df8784604192cb540dc5a::oscar_lion {
    struct OSCAR_LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR_LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR_LION>(arg0, 9, b"OSCAR", b"Oscar Lion", b"oscar lion on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776279662949-9373a076501dc86a07df0a803e2fb1f6.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OSCAR_LION>>(0x2::coin::mint<OSCAR_LION>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSCAR_LION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR_LION>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

