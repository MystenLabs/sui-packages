module 0xa28ec6ad50154f97896aa473b4e3c352f9cefb5ae246a9e9170e30dbe3701ce7::morrigan {
    struct MORRIGAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORRIGAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORRIGAN>(arg0, 9, b"MORRIGAN", b"Morrigan", b"MORRIGAN IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/079/574/630/large/jianbao-xu-select-a-file-name-for-output-files-004.jpg?1725286611")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MORRIGAN>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORRIGAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORRIGAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

