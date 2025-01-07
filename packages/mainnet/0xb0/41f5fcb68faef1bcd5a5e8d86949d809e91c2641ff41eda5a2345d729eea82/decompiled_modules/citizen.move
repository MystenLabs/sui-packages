module 0xb041f5fcb68faef1bcd5a5e8d86949d809e91c2641ff41eda5a2345d729eea82::citizen {
    struct CITIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CITIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CITIZEN>(arg0, 6, b"Citizen", b"Double up citizen", b"For the suitizens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0526_f5a8209fde.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CITIZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CITIZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

