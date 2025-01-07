module 0xe52febdd13580eb9b7d2c6376f5b8a68154171d6723b504c45b8eec7685fc1fb::tickle {
    struct TICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKLE>(arg0, 6, b"TICKLE", b"Tickle", b"They call me $TICKLE. Your best red friend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_d1956e275a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

