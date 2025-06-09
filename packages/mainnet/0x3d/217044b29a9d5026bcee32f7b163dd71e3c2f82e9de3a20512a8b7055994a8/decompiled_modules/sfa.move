module 0x3d217044b29a9d5026bcee32f7b163dd71e3c2f82e9de3a20512a8b7055994a8::sfa {
    struct SFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFA>(arg0, 6, b"SFA", b"Safemoon on Sui", b"Safemoon on SUI The Return of a Legend Safemoon defined a generation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihaso3rtthdk65kwh3rk7ji2kdiyegxvzgsjyj62eaeelsv47txbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

