module 0x97145409520453c54e9456e3cd846cd8b820483fea94829bd306a3a111eeeb6a::flintsui {
    struct FLINTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLINTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLINTSUI>(arg0, 6, b"FlintSui", b"Flint Pig Sui", b"Meet Flint: The Robot Pig Whos Here to Oink Up Crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1111_01_88abda02d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLINTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLINTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

