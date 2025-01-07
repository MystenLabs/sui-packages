module 0xaab545c09054557bd9633a62b9b9988c56949a175c2277af1a99ccb5fdd22421::zapo {
    struct ZAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAPO>(arg0, 6, b"ZAPO", b"Grandma Zapo", b"SUIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_Bx_J9_ZD_9_400x400_85d29a8d82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

