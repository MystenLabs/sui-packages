module 0x390ba7ac6e0551be7bf74d2821f46a324124bbaaa9fa0a86618b75d2d1870d73::suifinity {
    struct SUIFINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFINITY>(arg0, 6, b"SUIFINITY", b"6 Infinty SUI", b"I am SUinevitable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_68a691d6eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFINITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFINITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

