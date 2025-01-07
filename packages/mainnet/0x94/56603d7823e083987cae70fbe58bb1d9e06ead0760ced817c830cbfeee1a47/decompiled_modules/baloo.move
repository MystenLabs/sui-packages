module 0x9456603d7823e083987cae70fbe58bb1d9e06ead0760ced817c830cbfeee1a47::baloo {
    struct BALOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALOO>(arg0, 6, b"Baloo", b"SUI BALOO", b"The rebellion has already arrived. baloo will end all the memes that get in his way !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_084606_575_f5e64e36af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

