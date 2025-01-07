module 0x2556df6af979e1587750597ec49595a5bb8c1ef3e7a4fce61196503d6c59f06b::waddle {
    struct WADDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADDLE>(arg0, 6, b"Waddle", b"Waddle Waddle Pengu", b"WADDLEWADDLEPENGU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bmc_A7_Dks_400x400_99ddcebbd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WADDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

