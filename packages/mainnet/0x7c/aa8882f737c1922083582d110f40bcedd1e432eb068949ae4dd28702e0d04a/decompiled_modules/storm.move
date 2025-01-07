module 0x7caa8882f737c1922083582d110f40bcedd1e432eb068949ae4dd28702e0d04a::storm {
    struct STORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STORM>(arg0, 9, b"STORM", b"Tom", b"I am new in this world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64311edb-a53e-4fdb-b8f7-055b13c47df2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

