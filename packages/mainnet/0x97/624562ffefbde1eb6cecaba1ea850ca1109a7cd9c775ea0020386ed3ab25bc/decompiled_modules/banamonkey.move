module 0x97624562ffefbde1eb6cecaba1ea850ca1109a7cd9c775ea0020386ed3ab25bc::banamonkey {
    struct BANAMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANAMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANAMONKEY>(arg0, 6, b"BANAMONKEY", b"Banana Monkey", b"BANAMOKEY pair launch today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANAMONKEY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANAMONKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANAMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

