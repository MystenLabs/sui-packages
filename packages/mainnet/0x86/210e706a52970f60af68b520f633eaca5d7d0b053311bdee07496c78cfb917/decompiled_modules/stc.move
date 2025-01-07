module 0x86210e706a52970f60af68b520f633eaca5d7d0b053311bdee07496c78cfb917::stc {
    struct STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STC>(arg0, 6, b"STC", b"SUI Token Calls", b"Call Channel for SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MGA_LOGO_SOL_fea5bfbac5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STC>>(v1);
    }

    // decompiled from Move bytecode v6
}

