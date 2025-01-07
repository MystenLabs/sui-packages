module 0xa82b4033bb909837382faf6dd145550cee1ce32f643ed0b7176cb199e13ca829::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGE>(arg0, 6, b"FROGE", b"Froge Finance", b"Froge Finance with the Froge Finance Foundation, est. 2021 in The Hague, Netherlands, works directly with reputable non profit organizations to effectively use funds generated from Froge Finance tokens to plant trees and protect the rainforest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732847186048.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

