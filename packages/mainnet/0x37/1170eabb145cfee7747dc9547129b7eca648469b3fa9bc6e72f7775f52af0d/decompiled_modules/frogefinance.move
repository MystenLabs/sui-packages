module 0x371170eabb145cfee7747dc9547129b7eca648469b3fa9bc6e72f7775f52af0d::frogefinance {
    struct FROGEFINANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGEFINANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGEFINANCE>(arg0, 6, b"FROGEFINANCE", b"Froge Finance Foundation", b"Froge Finance with the Froge Finance Foundation, est. 2021 in The Hague, Netherlands, works directly with reputable non profit organizations to effectively use funds generated from Froge Finance tokens to plant trees and protect the rainforest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4253453_0e336b0471.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGEFINANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGEFINANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

