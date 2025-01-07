module 0x78f0f2edd0eb2eea813e9d127a205fa3487c5fb113bdbc36a96f84002e1f402d::rshib {
    struct RSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSHIB>(arg0, 9, b"RSHIB", b"RocketShib", b" Shiba Inu in orbit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b5063dc-9ccb-47d3-a451-41200f0df339.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

