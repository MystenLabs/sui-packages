module 0x3263ae1bc4784317472d6ac040d2bc7e36150d8e99dc0e45d046e6054bd57788::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"7k", b"Unofficially official token of 7k.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d17c1e096f77372993bc247868472ab7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

