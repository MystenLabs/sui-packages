module 0x7da3759aad990e4b237c63a5f370f093eb5b4fcea321683e5110388feb24664a::ybt {
    struct YBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YBT>(arg0, 9, b"YBT", b"YourBestToken", b"great token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e52c3de2c536d27f7bb84e895ead4dd9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

