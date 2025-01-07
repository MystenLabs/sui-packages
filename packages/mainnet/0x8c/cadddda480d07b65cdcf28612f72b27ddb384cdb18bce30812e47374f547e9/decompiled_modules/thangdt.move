module 0x8ccadddda480d07b65cdcf28612f72b27ddb384cdb18bce30812e47374f547e9::thangdt {
    struct THANGDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THANGDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THANGDT>(arg0, 9, b"THANGDT", b"Thang", b"My money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f83cf050-7ec7-43d6-9040-d8f9664bce5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THANGDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THANGDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

