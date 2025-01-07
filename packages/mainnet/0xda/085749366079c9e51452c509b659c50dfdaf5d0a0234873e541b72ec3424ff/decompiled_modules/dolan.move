module 0xda085749366079c9e51452c509b659c50dfdaf5d0a0234873e541b72ec3424ff::dolan {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 6, b"DOLAN", b"Dolan Duck", x"4c6f6f6b206174206d692c20446f6c616e20697a2064652063707461696e206e6f772e20446f7878656420436f6d6d756e6974792054616b656f7665720a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U9w_In7_NX_400x400_934b0d5d79_5efd06afee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

