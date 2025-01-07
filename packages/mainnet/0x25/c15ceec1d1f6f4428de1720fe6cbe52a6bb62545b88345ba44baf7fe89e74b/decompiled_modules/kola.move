module 0x25c15ceec1d1f6f4428de1720fe6cbe52a6bb62545b88345ba44baf7fe89e74b::kola {
    struct KOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLA>(arg0, 6, b"KOLA", b"Kola on SUI", b"Why did the lazy KOLA join the SUI network? Because even he thought blockchain transactions should be faster than his naps!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_2024_10_02_T202310_144_9405700445.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

