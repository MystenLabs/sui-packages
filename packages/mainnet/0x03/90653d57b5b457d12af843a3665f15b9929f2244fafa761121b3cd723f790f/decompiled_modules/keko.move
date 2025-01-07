module 0x390653d57b5b457d12af843a3665f15b9929f2244fafa761121b3cd723f790f::keko {
    struct KEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKO>(arg0, 6, b"KEKO", b"Sui Keko", b"$KEKO. The most memeable memecoin in existence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_48_469797b71a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

