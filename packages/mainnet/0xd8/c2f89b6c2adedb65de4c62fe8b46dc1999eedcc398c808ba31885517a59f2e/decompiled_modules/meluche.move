module 0xd8c2f89b6c2adedb65de4c62fe8b46dc1999eedcc398c808ba31885517a59f2e::meluche {
    struct MELUCHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELUCHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELUCHE>(arg0, 9, b"MELUCHE", b"Melenchon", b"A nice guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5aa7f2c5111aef74c13537ecd6638cc7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELUCHE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELUCHE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

