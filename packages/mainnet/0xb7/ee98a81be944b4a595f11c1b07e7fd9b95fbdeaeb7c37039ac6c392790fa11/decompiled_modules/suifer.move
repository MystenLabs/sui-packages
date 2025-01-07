module 0xb7ee98a81be944b4a595f11c1b07e7fd9b95fbdeaeb7c37039ac6c392790fa11::suifer {
    struct SUIFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFER>(arg0, 6, b"SUIFER", b"SuiferOnSui", b"SUIFER rides the waves of the Sui chain with the grace of a Shiba Inu on a surfboard! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000519_700692fc1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

