module 0x1c57773a70c066ddd3ad9ed16f6a304d092913532247fc76c94af27d9e4d050e::monkeysui {
    struct MONKEYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEYSUI>(arg0, 6, b"MONKEYSUI", b"MONKEY SUI", b"Official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MONKEY_2222_badcde111b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

