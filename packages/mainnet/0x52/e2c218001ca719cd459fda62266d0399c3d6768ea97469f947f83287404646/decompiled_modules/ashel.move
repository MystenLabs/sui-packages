module 0x52e2c218001ca719cd459fda62266d0399c3d6768ea97469f947f83287404646::ashel {
    struct ASHEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHEL>(arg0, 6, b"ASHEL", b"Astro Turtle Shel", b"The fastest turtle in the universe, Ashel is more than memecoin-it's your ticket to the stars!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009339_0c2d1a2fc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASHEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

