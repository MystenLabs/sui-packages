module 0x925b083a138a7f6b9a170e7741848fe2bf5268894558755ab8d93bff21f8145c::pelf {
    struct PELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELF>(arg0, 6, b"PELF", b"Official Pelfort Sui", b"Website: https://www.pelfortsui.lol TG: https://t.me/PelfortOnSui X:https://x.com/Pelfort_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_11_cfbf377fda.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

