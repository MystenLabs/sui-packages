module 0x8ff7683ccb0d5d8c78f8cf2f7744be73f050148966cac753fae978ca22cb27c9::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 9, b"WEWE", b"WEWEE", b"WEWE is the best meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/71919fa5f5277046ada07db6b58ff7a1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

