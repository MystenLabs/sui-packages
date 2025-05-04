module 0xdb5099c1357e422a0e3ee837071945ca983db2d10035bb94492f0c5e400ab280::wapda {
    struct WAPDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAPDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAPDA>(arg0, 9, b"Wapda", b"fesco", b"wapda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d092f4ae412528c8cb218ba6f1a4b649blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAPDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAPDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

