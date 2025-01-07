module 0xf6ed275d2e550f69b702c8f864cd8252cc1d5cea2a3c17f0256fc702e972338f::pscat {
    struct PSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSCAT>(arg0, 6, b"PSCAT", b"PowerShell Cat", b"meow cat meow code", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pscat1_bd178ed31e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

