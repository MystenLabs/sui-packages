module 0x87bb807e1a6cfb4686533bd38ada08ec1c02ac94f4d3b6f111c1be591b95a027::earth {
    struct EARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARTH>(arg0, 6, b"Earth", b"Earth on Sui", b"he world will be more sophisticated than ever $EARTH is a good name for the universe, and we live on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_1547d75ca4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EARTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

