module 0xd63637738ab3fbcba40efafd51f9ace8e57520675f22b8dec476c18b6139dc52::phoenix {
    struct PHOENIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHOENIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHOENIX>(arg0, 6, b"PHOENIX", b"Sui Phoenix", b"Rising from the ashes, $PHOENIX brings new life and opportunity to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_75_b90e912a96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHOENIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHOENIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

