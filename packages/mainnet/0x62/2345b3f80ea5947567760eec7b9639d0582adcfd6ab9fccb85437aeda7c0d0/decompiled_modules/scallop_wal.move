module 0x622345b3f80ea5947567760eec7b9639d0582adcfd6ab9fccb85437aeda7c0d0::scallop_wal {
    struct SCALLOP_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WAL>(arg0, 9, b"sWAL", b"sWAL", b"Scallop interest-bearing token for WAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://demac7qmvo7cyr42swwzpki63in27j35g4b6rropmrwsmiszjbsq.arweave.net/GRgBfgyrvixHmpWtl6ke2huvp303A-jFz2RtJiJZSGU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

