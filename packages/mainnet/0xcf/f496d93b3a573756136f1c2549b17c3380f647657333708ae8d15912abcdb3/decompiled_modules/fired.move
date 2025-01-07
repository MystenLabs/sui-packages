module 0xcff496d93b3a573756136f1c2549b17c3380f647657333708ae8d15912abcdb3::fired {
    struct FIRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRED>(arg0, 6, b"Fired", b"Fire Gensler", b"Gensler Fired", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731389231113.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

