module 0xf3e5fd8b021f0c7189bcbc0d7e84e92eac6fa73ffce2e6966e82f24f3749be0::chinatrump {
    struct CHINATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINATRUMP>(arg0, 9, b"CHINATRUMP", b"CHINAVSTRUMP", b"JUST THIS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8eb1663d6cd09a98cfd0cc4dafffb261blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINATRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINATRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

