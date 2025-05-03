module 0x22acc1c1d784d2ccad33fbab01e60537d01615c328c5e09aca79c277cff71328::walph {
    struct WALPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALPH>(arg0, 9, b"WAlPH", b"WALALPHA", b"Our one Our only Walrus Alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9da078d68294922cf335926f6fd4335dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALPH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALPH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

