module 0x66320bab3278e9f480494c8f3b666ef3e7833766402b85bf995e1979c4a467b6::suiday {
    struct SUIDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAY>(arg0, 9, b"SUIDAY", b"2025.SUIDAY", b"Its Sui day, lets make it count", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5d685214670a3bad9cb45fdffe297645blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

