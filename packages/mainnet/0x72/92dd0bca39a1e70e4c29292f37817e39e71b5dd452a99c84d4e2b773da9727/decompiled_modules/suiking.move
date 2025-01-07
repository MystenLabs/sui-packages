module 0x7292dd0bca39a1e70e4c29292f37817e39e71b5dd452a99c84d4e2b773da9727::suiking {
    struct SUIKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKING>(arg0, 6, b"SUIKING", b"Sui King", b"A majestic token of oceanic power and wisdom, embodying the strength and sovereignty of the seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fotor_ai_202410281285_4ae9bdca9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

