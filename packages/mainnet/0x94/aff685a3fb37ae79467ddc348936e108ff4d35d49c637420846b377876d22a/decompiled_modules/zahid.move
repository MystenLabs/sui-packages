module 0x94aff685a3fb37ae79467ddc348936e108ff4d35d49c637420846b377876d22a::zahid {
    struct ZAHID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAHID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAHID>(arg0, 9, b"ZAHID", b"Muhammed", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ceb91ffa-7073-438b-9d14-18f5d3706252.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAHID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAHID>>(v1);
    }

    // decompiled from Move bytecode v6
}

