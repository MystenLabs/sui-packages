module 0xd58a24d6764fbcc0a9bf276120db75dad8b0e2706b42176aa56dd7d555428099::bobo_sui {
    struct BOBO_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO_SUI>(arg0, 9, b"BOBO", b"Bobo Sui", b"BOBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776611696896-e6318792f953e0b8a5587db5676d0f53.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BOBO_SUI>>(0x2::coin::mint<BOBO_SUI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBO_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO_SUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

