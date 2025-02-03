module 0x74095f9263a640e9360afb4679e73465ccda3b6ac0b3fc27e451ac620f718739::peachcat {
    struct PEACHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACHCAT>(arg0, 6, b"PeachCat", b"PeachCat  on sui", x"57697368696e6720796f7520616c776179732062652066756c6c206f66206a6f7920616e6420706f73697469766520656e65726779206c696b6520746865206c6f76656c7920506561636843617420636174732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_01_10_23_42_c36e727268.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

