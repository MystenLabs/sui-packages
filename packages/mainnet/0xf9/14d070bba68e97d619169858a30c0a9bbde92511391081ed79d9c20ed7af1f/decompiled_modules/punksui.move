module 0xf914d070bba68e97d619169858a30c0a9bbde92511391081ed79d9c20ed7af1f::punksui {
    struct PUNKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKSUI>(arg0, 9, b"Punksui", b"suipunk", b"Punk on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6f6b86c704f625a0166d163e9ea24cb4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

