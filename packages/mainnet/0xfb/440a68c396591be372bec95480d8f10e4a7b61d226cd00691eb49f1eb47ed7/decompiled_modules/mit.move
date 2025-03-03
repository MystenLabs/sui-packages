module 0xfb440a68c396591be372bec95480d8f10e4a7b61d226cd00691eb49f1eb47ed7::mit {
    struct MIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIT>(arg0, 9, b"MIT", b"mite", b"mite crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8858659b6bdbc2c1131a737dd29566b9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

