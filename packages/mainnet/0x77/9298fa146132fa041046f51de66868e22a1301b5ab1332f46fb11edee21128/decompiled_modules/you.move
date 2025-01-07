module 0x779298fa146132fa041046f51de66868e22a1301b5ab1332f46fb11edee21128::you {
    struct YOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOU>(arg0, 9, b"YOU", b"Yourame", b"You are my angle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bf5ea23-6437-4213-a72e-adcc766e0656.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

