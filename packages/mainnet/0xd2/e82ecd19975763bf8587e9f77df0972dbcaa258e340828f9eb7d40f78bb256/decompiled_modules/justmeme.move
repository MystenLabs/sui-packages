module 0xd2e82ecd19975763bf8587e9f77df0972dbcaa258e340828f9eb7d40f78bb256::justmeme {
    struct JUSTMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTMEME>(arg0, 6, b"Justmeme", b"911", b"Just memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Osama_bin_Laden_portrait_59cb3e9d16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

