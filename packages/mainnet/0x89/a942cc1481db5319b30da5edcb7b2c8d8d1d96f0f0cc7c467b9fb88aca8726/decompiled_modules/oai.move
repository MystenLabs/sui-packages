module 0x89a942cc1481db5319b30da5edcb7b2c8d8d1d96f0f0cc7c467b9fb88aca8726::oai {
    struct OAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OAI>(arg0, 6, b"OAI", b"Octopus AI", b"From depths to domains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250108_102820_701_767b7b3281.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

