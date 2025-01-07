module 0xf59190da387988138297162250d81fefe9e860efc3c95fffa93cc384c8355bac::ndsui {
    struct NDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDSUI>(arg0, 9, b"NDSUI", b"Notre-Dame", b"Just because it s Notre Dame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f8b5ee57f4fafb9687d5ed72333d77b3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

