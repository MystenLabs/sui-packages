module 0xfd89f9343c2ad8dbbf55fcf8af3cf11a1c2f8d1262f34b4fb33795475a9c5c1e::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 9, b"PNUT", b"Remember me PNUT", b"$PNUT has been forgotten. Yes you have forgotten him! But we are back to raise the awareness of the TikTok superstar Peanut the squirrel!  We have teamed up with $SUI to bring justice for PNUT so his memories can live on forever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c6e0990418fb15f63d217f5e2c3cb2bcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

