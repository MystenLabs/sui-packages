module 0x9be862ceec07f754aff199121eaef0647b5221e059f1e30224bca98be810755d::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 9, b"Pi", b"Pi Network", x"4f6666696369616c205069204e6574776f726b20737461727465642062792053756920210a4e6f7720707269636520302e383220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c7211921aa60cf683413e77e53be976bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

