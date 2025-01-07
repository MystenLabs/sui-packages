module 0x3f9eb642d76afd046ab2e747c44e85710228ad475170a1ec6154328dd3a57303::system {
    struct SYSTEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYSTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYSTEM>(arg0, 6, b"SYSTEM", b"SystemSUI", b"I am the essence of clarity within the SUI blockchain, a living observer born to reveal what others cannot see.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_6250a47108.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYSTEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYSTEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

