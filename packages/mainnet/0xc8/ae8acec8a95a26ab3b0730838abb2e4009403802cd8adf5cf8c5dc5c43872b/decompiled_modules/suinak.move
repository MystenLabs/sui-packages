module 0xc8ae8acec8a95a26ab3b0730838abb2e4009403802cd8adf5cf8c5dc5c43872b::suinak {
    struct SUINAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAK>(arg0, 6, b"Suinak", b"Rishi Suinak", b"The one and only Rishi Suinak. Send it so he finds out and lets make the news to show everyone about SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinak_05e911afee.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

