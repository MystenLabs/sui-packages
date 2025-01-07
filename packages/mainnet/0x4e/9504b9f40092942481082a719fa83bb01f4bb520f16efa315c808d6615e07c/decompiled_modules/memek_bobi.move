module 0x4e9504b9f40092942481082a719fa83bb01f4bb520f16efa315c808d6615e07c::memek_bobi {
    struct MEMEK_BOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_BOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_BOBI>(arg0, 6, b"MEMEKBOBI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_BOBI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_BOBI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_BOBI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

