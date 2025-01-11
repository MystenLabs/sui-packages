module 0x16ab6a14d76a90328a6b04f06b0a0ce952847017023624e0c37bf8aa314c39ba::shr {
    struct SHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHR>(arg0, 9, b"SHR0", b"SroomAI DAO", b"SroomAI DAO - the first AI hedge fund for AI projects investment on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidaos.com/logo/shro.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHR>>(v1);
        0x2::coin::mint_and_transfer<SHR>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHR>>(v2);
    }

    // decompiled from Move bytecode v6
}

