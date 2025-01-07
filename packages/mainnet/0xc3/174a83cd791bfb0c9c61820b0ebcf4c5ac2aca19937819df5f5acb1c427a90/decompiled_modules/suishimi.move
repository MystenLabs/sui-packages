module 0xc3174a83cd791bfb0c9c61820b0ebcf4c5ac2aca19937819df5f5acb1c427a90::suishimi {
    struct SUISHIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIMI>(arg0, 6, b"SUISHIMI", b"Suishimi", b"Suishimi, the cutest sashimi on the Sui Network, swims through the blockchain with a splash of color and an irresistible smile. With every byte, this adorable dish brings a delightful flavor to the digital world, making every transaction a tasty treat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_19_50_02_8c9093f502.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

