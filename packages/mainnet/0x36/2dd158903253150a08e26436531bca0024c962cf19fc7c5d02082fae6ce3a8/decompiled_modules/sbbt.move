module 0x362dd158903253150a08e26436531bca0024c962cf19fc7c5d02082fae6ce3a8::sbbt {
    struct SBBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBBT>(arg0, 9, b"SBBT", b"SBBT", b"SBBT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBBT>>(v1);
        0x2::coin::mint_and_transfer<SBBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SBBT>>(v2);
    }

    // decompiled from Move bytecode v6
}

