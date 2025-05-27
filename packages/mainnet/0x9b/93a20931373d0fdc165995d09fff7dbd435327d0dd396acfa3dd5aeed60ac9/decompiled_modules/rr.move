module 0x9b93a20931373d0fdc165995d09fff7dbd435327d0dd396acfa3dd5aeed60ac9::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RR>(arg0, 9, b"RR", b"Reef Rift", b"Starfish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9f1251c5f8d286b0b8480fb7db87956dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

