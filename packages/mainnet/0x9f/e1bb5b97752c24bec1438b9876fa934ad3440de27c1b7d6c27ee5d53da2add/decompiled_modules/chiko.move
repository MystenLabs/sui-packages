module 0x9fe1bb5b97752c24bec1438b9876fa934ad3440de27c1b7d6c27ee5d53da2add::chiko {
    struct CHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIKO>(arg0, 9, b"CHIKO", b"Hachiko", b"This my dogs name go on if you want donate to Chiko foods", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4a0be52-36e5-4324-ac84-1ea408f383b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

