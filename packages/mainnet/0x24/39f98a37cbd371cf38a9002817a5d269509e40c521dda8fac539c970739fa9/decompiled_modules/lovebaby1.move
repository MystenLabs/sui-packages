module 0x2439f98a37cbd371cf38a9002817a5d269509e40c521dda8fac539c970739fa9::lovebaby1 {
    struct LOVEBABY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVEBABY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVEBABY1>(arg0, 9, b"Lovebaby1", b"baby1", b"Lovebaby111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/69929530cd01442dba274a0f45b7aa7dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVEBABY1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVEBABY1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

