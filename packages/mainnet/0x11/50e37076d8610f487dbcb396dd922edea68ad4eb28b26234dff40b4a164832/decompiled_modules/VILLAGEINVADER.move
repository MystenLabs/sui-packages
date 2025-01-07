module 0x1150e37076d8610f487dbcb396dd922edea68ad4eb28b26234dff40b4a164832::VILLAGEINVADER {
    struct VILLAGEINVADER has drop {
        dummy_field: bool,
    }

    fun init(arg0: VILLAGEINVADER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VILLAGEINVADER>(arg0, 0, b"COS", b"VILLAGE INVADER", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-to those who trespassed into the village through whatever means necessary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/VILLAGE_INVADER.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VILLAGEINVADER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VILLAGEINVADER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

