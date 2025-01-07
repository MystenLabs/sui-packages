module 0x3206f939c04cbdd21cc2ad3ba10fae4eed1119b3b3837cb8952fe216ba8b4e02::YEETEDBYRAHMA {
    struct YEETEDBYRAHMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEETEDBYRAHMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEETEDBYRAHMA>(arg0, 0, b"COS", b"YEETED BY RAHMA", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-to those unexpectedly yeeted by an Aurahma merely passing through.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/YEETED_BY_RAHMA.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YEETEDBYRAHMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEETEDBYRAHMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

