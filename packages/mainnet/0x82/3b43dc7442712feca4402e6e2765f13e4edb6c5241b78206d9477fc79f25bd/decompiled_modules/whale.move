module 0x823b43dc7442712feca4402e6e2765f13e4edb6c5241b78206d9477fc79f25bd::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Captain Whale", b"Captain  (Captain Whale) is the legendary leader of the deep, ruling over the ocean with wisdom and strength.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Een_titel_toevoegen_da4bbab729.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

