module 0x3727138020ccb936f773cd9459f085e92140cc6c15d7f78fc0d0ca7f5601839a::no {
    struct NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO>(arg0, 9, b"No", b"NoLock", b"Nolock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/979dd936ab797b9d216f37d9545a70a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

