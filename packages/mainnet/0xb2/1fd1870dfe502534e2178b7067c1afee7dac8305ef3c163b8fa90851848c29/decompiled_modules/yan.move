module 0xb21fd1870dfe502534e2178b7067c1afee7dac8305ef3c163b8fa90851848c29::yan {
    struct YAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAN>(arg0, 9, b"YAN", b"$YAN", b"OFFICIAL $YAN FAN TOKEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/57c5204beccad2d69e9d5636624c9fe1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

