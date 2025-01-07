module 0x5d86fb402a2ed8df27d5353db2864ed125a883dd29572b585dabf67eb43ff358::pscat {
    struct PSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSCAT>(arg0, 6, b"PSCat", b"PowerShell Cat", b"meow cat meow code", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pscat1_5e9da4c461.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

