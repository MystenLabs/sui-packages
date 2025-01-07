module 0xf42a26e9b7cc0a7132ffcbde03883f3b15e7636202dd9cf05ed54afee89016e6::lvt_07 {
    struct LVT_07 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LVT_07, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVT_07>(arg0, 9, b"LVT_07", b"lT", b"a vip token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6c1fbdd-0bb2-47c3-be94-7cad58d99dc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVT_07>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LVT_07>>(v1);
    }

    // decompiled from Move bytecode v6
}

