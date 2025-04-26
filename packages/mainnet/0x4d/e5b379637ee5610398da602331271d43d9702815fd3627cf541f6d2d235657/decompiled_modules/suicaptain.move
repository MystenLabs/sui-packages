module 0x4de5b379637ee5610398da602331271d43d9702815fd3627cf541f6d2d235657::suicaptain {
    struct SUICAPTAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAPTAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAPTAIN>(arg0, 9, b"SuiCaptain", b"Sui Captain ", b"Here is Sui Captain to save Sui Ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e3bdbdd03de646dca6e56e9d7f2796eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAPTAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAPTAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

