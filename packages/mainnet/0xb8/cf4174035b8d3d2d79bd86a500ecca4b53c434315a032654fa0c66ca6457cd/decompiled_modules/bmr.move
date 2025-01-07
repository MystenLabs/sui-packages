module 0xb8cf4174035b8d3d2d79bd86a500ecca4b53c434315a032654fa0c66ca6457cd::bmr {
    struct BMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMR>(arg0, 6, b"BMR", b"Baby misser", b"this is a baby misser, if you doubt, you won't get rich, you have to start with risk, don't miss ser", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052495_8220112e5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

