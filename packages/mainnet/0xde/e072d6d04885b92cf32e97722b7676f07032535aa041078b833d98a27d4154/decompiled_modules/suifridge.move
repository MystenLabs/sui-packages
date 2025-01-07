module 0xdee072d6d04885b92cf32e97722b7676f07032535aa041078b833d98a27d4154::suifridge {
    struct SUIFRIDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFRIDGE>(arg0, 6, b"SuiFridge", b"Sui Fridge", x"546869732066697273742053756920746f6b656e206c61756e63686564206f6e206120536d617274204672696467650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zlr_Ma_X1_400x400_1_ecb0b2b5ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRIDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFRIDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

