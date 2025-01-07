module 0xbd630c70e4d4ebb40a0477b31fd22b7089d014c1bc7c45af7b4f7a1e2b6f5ed::tardoc {
    struct TARDOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDOC>(arg0, 6, b"TARDOC", b"TARDOSUI", b"Tardocoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tardoeh_0277e17a77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARDOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

