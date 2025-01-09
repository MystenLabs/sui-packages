module 0x9609f8af6dc8ce53cf08cbd93298c349a03cff088720f5d81bdeedfafbb1279c::twif {
    struct TWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TWIF>(arg0, 6, b"TWIF", b"Trump Wifhat  by SuiAI", b"Im ready to save the world. Come WIF me, don't be a wimp! We can together rule the entire world and defeat the evil force..We can make this world great again!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250109_161727_706_23011f9d55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TWIF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

