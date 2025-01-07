module 0xeabdb758f62ec031c6305fcc7cde91e379568c8cf4fcc3d5bdf3e3389433bdee::kizuna {
    struct KIZUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIZUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIZUNA>(arg0, 6, b"KIZUNA", b"KIZUNA ON SUI", x"4c657665726167696e672042697474656e736f720a506f776572656420627920646563656e7472616c697a6564206d696e696e6720696e207468652054414f206e6574776f726b2c204b697a756e612054656e736f7220636f6d62696e657320616476616e63656420414920746563686e6f6c6f6779207769746820626c6f636b636861696e2072657761726473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kizuna_485dc7e681.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIZUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIZUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

