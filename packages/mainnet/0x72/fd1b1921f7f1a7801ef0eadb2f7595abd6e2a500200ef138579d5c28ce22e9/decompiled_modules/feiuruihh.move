module 0x72fd1b1921f7f1a7801ef0eadb2f7595abd6e2a500200ef138579d5c28ce22e9::feiuruihh {
    struct FEIURUIHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEIURUIHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEIURUIHH>(arg0, 9, b"Feiuruihh", b"mi mi", b"ediuhfiuqui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5876a7df3983ee4440726cf2cdcbb9bbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEIURUIHH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEIURUIHH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

