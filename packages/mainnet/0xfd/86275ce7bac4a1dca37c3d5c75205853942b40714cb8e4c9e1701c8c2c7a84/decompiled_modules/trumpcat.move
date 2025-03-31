module 0xfd86275ce7bac4a1dca37c3d5c75205853942b40714cb8e4c9e1701c8c2c7a84::trumpcat {
    struct TRUMPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCAT>(arg0, 9, b"TRUMPCAT", b"Catcoin", b"TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f0dcfeff9a897f5c3c644f1ebae077dbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

