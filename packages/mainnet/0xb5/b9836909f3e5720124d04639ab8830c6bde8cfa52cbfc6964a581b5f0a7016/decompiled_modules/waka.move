module 0xb5b9836909f3e5720124d04639ab8830c6bde8cfa52cbfc6964a581b5f0a7016::waka {
    struct WAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKA>(arg0, 9, b"Waka", b"wakanda", b"remember wakanda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/49264e48159f189572da5dae43e82026blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

