module 0x5ac30d4138c852ffe74f2edfebdc8a4e320288f02bbd45b81f44b9dea42e5bda::duo {
    struct DUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUO>(arg0, 9, b"Duo", b"Duolingo Owl", b"Rest in Peace Duo aka The Duolingo Owl ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaEsqufP3MNknmqPapaqhjoMZz3CF7UMbihyyqfiparWF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

