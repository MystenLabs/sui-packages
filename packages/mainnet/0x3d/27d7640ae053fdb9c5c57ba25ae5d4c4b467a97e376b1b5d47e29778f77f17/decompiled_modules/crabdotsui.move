module 0x3d27d7640ae053fdb9c5c57ba25ae5d4c4b467a97e376b1b5d47e29778f77f17::crabdotsui {
    struct CRABDOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABDOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRABDOTSUI>(arg0, 6, b"CRABDOTSUI", b"CrabDotSui", b"SCRAB..1..launches..is..a decentralized meme coin built on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000066314_85d0b29071.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRABDOTSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABDOTSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

