module 0x7a289e30ed828f15bb8705980469d9989e91879e12657032e796ee983435f791::tcc {
    struct TCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCC>(arg0, 9, b"TCC", b"3 CAT ", b"It grows 300%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a7dc4bd-cffc-492c-a381-d2ab4bdde2fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

