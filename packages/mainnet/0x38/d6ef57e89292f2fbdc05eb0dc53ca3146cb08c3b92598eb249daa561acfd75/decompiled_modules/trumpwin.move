module 0x38d6ef57e89292f2fbdc05eb0dc53ca3146cb08c3b92598eb249daa561acfd75::trumpwin {
    struct TRUMPWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWIN>(arg0, 9, b"TRUMPWIN", b"Trump Win", b"Trump Win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/Qmea15FeJ66zpu9J6EYePXog8SzXw5b4SkyasnyRtTg7NA"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWIN>>(v1);
        0x2::coin::mint_and_transfer<TRUMPWIN>(&mut v2, 1000000000000000000, @0xa412972267c72069b0a97081e6b4c23c75297b8f25062a8643b06dd7e37310b8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMPWIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

