module 0x800a68cb9f2448c41354e7144855448c5a573b7d26b01de6139cd55e64b4d88e::satorucalls {
    struct SATORUCALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATORUCALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATORUCALLS>(arg0, 6, b"t.me/SatoruCalls", b"t.me/SatoruCalls", b"telegram: SatoruCalls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/F8amRgy.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATORUCALLS>>(v1);
        0x2::coin::mint_and_transfer<SATORUCALLS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SATORUCALLS>>(v2);
    }

    // decompiled from Move bytecode v6
}

