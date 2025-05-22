module 0x1a03ab7493cbe0e50874843f40fe39498d538c1d835c8a57d29f4c67bef84217::suisquatch {
    struct SUISQUATCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISQUATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISQUATCH>(arg0, 6, b"SUISQUATCH", b"SUISQUATCH COIN", b"SUISQUATCH THE ILLUSIVE MATRIX CRYPTO CRYPTIC THAT CAN SCALE THE SUI CHARTS FASTER THAN IT CAN SCALE MOUNT EVEREST ON A FULL MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747903215255.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISQUATCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISQUATCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

