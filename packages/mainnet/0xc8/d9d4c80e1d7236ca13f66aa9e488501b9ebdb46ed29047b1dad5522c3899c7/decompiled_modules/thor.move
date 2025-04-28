module 0xc8d9d4c80e1d7236ca13f66aa9e488501b9ebdb46ed29047b1dad5522c3899c7::thor {
    struct THOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOR>(arg0, 9, b"Thor", b"Thorianos", b"far from home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d666e4793bbfe1b943fcee25a6152df9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

