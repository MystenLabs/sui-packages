module 0x4166634e7c03471a74b28e313fcc46600c4f373505941a78c22bcde9be023fb5::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 9, b"MOB", b"maxlab coin", b"the new meme coin of sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3037284446ccd09c218d6ba8f0fa2524blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

