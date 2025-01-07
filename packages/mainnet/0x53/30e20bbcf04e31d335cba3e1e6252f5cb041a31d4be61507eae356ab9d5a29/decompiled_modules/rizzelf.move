module 0x5330e20bbcf04e31d335cba3e1e6252f5cb041a31d4be61507eae356ab9d5a29::rizzelf {
    struct RIZZELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZELF>(arg0, 6, b"RIZZELF", b"Rizz Elf on SUI", b"RizzElf  | Santas little helper sharing $Rizzmas & $RizzmasEve!  Spreading festive cheer,crypto magic this holiday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Hqd_VEM_7_400x400_253779bc97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

