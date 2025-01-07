module 0xf43a8fe36b065f686edf1df2a456a08759cd12f3f68600270f4984754f3109fa::stepbro {
    struct STEPBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEPBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPBRO>(arg0, 6, b"STEPBRO", b"SUItepbro", b"Suitepbro doin his best before No Nut November", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/93kb82_968a449018.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPBRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEPBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

