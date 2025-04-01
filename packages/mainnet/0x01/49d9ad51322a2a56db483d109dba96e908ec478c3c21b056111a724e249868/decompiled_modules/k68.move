module 0x149d9ad51322a2a56db483d109dba96e908ec478c3c21b056111a724e249868::k68 {
    struct K68 has drop {
        dummy_field: bool,
    }

    fun init(arg0: K68, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K68>(arg0, 9, b"K68", b"liuf", b"xgyi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/aabc0e8fe917788060e28775053d770ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K68>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K68>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

