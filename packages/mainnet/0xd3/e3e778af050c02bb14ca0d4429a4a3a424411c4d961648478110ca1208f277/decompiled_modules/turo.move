module 0xd3e3e778af050c02bb14ca0d4429a4a3a424411c4d961648478110ca1208f277::turo {
    struct TURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURO>(arg0, 6, b"TURO", b"SuiTuro", b" Turo - The Spirit of SUI | Strength in Unity, Power in Growth  | Join the Movement and Charge Ahead!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057764_5d7279f9f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURO>>(v1);
    }

    // decompiled from Move bytecode v6
}

