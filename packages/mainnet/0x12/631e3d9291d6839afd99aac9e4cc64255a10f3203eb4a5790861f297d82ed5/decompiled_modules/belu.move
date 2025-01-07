module 0x12631e3d9291d6839afd99aac9e4cc64255a10f3203eb4a5790861f297d82ed5::belu {
    struct BELU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELU>(arg0, 6, b"Belu", b"Beluga", b"Let's create our own world by traveling the five oceans and six continents. Let's create our own Beluga without anyone's interference.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_1_fba83fb22f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELU>>(v1);
    }

    // decompiled from Move bytecode v6
}

