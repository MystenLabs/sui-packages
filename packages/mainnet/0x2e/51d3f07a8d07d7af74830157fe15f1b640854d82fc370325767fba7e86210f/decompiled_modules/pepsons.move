module 0x2e51d3f07a8d07d7af74830157fe15f1b640854d82fc370325767fba7e86210f::pepsons {
    struct PEPSONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSONS>(arg0, 6, b"PEPSONS", b"PEPSONSUI", b"The $PEPSONS Memeing on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_23_37_17_3011c1957a_d00dd2d887.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

