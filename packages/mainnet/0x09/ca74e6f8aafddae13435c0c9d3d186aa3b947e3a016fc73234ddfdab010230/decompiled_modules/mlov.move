module 0x9ca74e6f8aafddae13435c0c9d3d186aa3b947e3a016fc73234ddfdab010230::mlov {
    struct MLOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLOV>(arg0, 9, b"MLOV", b"Memelov", b"Thiss is token for you Those who need love, collect as much as possible to increase their love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65254019-91f7-49d7-85d6-f3e71e0bc68c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

