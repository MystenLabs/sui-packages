module 0x4f139b228d33ef3ef39e40f86615f8f75826158ed47a855f2dc08d415e5fd66f::sario {
    struct SARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARIO>(arg0, 6, b"Sario", b"Sui Mario", b"Meet Sui Shotgun Sario. First Memecoin 8-bit adventure on Sui. Inspired by classic Mario vibes, this token brings you the ultimate gaming experience where Mario battles monsters with shotguns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sario_Final_4f63a61700.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

