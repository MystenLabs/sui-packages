module 0xf2d6fb6388db68fac8075b0303188fd90badb1265a112c2f62a3535acb57519f::fbox {
    struct FBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBOX>(arg0, 9, b"FBOX", b"Ring of Death", b"And you tought you had seen everything in crypto? Not one person who can dream of any feeling weirder then this to observe and experience... Enjoy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/450b199d5cd130e98b75be87351702cdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FBOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

