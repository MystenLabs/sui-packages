module 0xdcb2856704ebda43ad27e2e61e101a49a8acceb54c857052bcf5b87a2134ca4e::skal {
    struct SKAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKAL>(arg0, 9, b"Skal", b"SKALES", b"SKALES a KOI born on SUI. The fish on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7b69fcd50d7dd516b578600a951f2583blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

