module 0x16bde6f4eef6b77647461cd2540e455abb6ed53bfc04c6296155ec74af0374e8::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 9, b"DROP", b"Drop", b"Take Drop - Get Drop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e8f41a6-b46f-459a-ad15-58fd623969f8-1000021680.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

