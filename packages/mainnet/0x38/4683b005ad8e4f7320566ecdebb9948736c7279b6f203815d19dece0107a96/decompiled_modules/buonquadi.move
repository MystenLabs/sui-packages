module 0x384683b005ad8e4f7320566ecdebb9948736c7279b6f203815d19dece0107a96::buonquadi {
    struct BUONQUADI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUONQUADI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUONQUADI>(arg0, 9, b"BUONQUADI", b"nhunaoo", b"App luc qua :((( ko biet phai lam gi tiep theo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/59129952d9479361bf66840e3c2fa511blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUONQUADI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUONQUADI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

