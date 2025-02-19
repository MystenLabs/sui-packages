module 0x1ddc86435cca8ce953d8b3488104cd6cd0a156d706485aa34a525093216e4bd6::themask {
    struct THEMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEMASK>(arg0, 6, b"TheMask", b"The Mask On Sui", b"We're glad you joined us. The unique The Mask group is a place for people to share and discover unique, creative and impressive masks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_7f4d9086be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

