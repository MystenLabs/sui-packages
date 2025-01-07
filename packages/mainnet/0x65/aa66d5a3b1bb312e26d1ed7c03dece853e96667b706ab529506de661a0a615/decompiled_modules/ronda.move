module 0x65aa66d5a3b1bb312e26d1ed7c03dece853e96667b706ab529506de661a0a615::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"RONDA", b"Ronda On Sui", b"$Ronda On Sui on the Road to Bigger and Better Things! Never Looking Back! https://linktr.ee/rondaonsui TG: https://t.me/RondaOnSuiportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ronda_d087e2d863.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

