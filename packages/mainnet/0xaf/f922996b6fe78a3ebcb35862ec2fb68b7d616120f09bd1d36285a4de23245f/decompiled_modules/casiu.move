module 0xaff922996b6fe78a3ebcb35862ec2fb68b7d616120f09bd1d36285a4de23245f::casiu {
    struct CASIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASIU>(arg0, 6, b"Casiu", b"Casuio", x"412077656c6c2d6b6e6f776e204a6170616e65736520636f6d70616e792022436173696f22206c696b6564202473756920736f206d75636820746861742074686579206465636964656420746f206f70656e2068657265206e6f77200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cas_8fa8c0841d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

