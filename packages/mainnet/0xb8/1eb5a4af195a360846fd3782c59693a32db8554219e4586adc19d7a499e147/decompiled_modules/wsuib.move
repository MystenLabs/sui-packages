module 0xb81eb5a4af195a360846fd3782c59693a32db8554219e4586adc19d7a499e147::wsuib {
    struct WSUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUIB>(arg0, 6, b"WSUIB", b"Wall sui Boys", b"Wall sui Boys to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026505_607a9074b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

