module 0xe1b72e035d2d57411d945c7adb75c16787ca3a4ca43925bcde1fd379374ff00::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 6, b"Len", b"LEN SASSAMAN", b"Len Sassaman is another possible contender to be Satoshi Nakamoto. \"I've moved on to other things and probably won't be around in the future,\" shortly after this last message from the BTC creator, Sassaman committed suicide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060374_d32b645f82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

