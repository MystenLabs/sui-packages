module 0x5f53e352c727cb3a2a5380e23a332951a87b493daee4d78f0eef6d32ab5b485d::meowmeo {
    struct MEOWMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMEO>(arg0, 9, b"MEOWMEO", b"Bibo", b"Amor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de151ad9-fb02-4492-a705-f3bce0fb05aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

