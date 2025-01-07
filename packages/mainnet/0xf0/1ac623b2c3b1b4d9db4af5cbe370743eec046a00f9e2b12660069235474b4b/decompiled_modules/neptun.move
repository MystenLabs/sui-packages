module 0xf01ac623b2c3b1b4d9db4af5cbe370743eec046a00f9e2b12660069235474b4b::neptun {
    struct NEPTUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUN>(arg0, 6, b"NEPTUN", b"NEPTUN on Sui", b"NEPTUN (NEPTUN)  The ruler of the blue planet, filled with endless oceans and mystery. On Sui, NEPTUN reigns supreme, bringing the power of the seas with it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_neptune_planetsmiling_happy_3e27e495_ab65_44b3_a0fa_85d91c36e1f7_1_b089825816.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPTUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

