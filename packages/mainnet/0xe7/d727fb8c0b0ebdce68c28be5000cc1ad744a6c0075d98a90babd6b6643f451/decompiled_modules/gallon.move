module 0xe7d727fb8c0b0ebdce68c28be5000cc1ad744a6c0075d98a90babd6b6643f451::gallon {
    struct GALLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALLON>(arg0, 6, b"GALLON", b"Gallon", b"Gallon on Sui Chain, Save your Sui in Gallon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_14_50_10_82916fb17e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GALLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

