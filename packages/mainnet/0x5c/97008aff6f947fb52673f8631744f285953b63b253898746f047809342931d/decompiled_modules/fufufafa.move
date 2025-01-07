module 0x5c97008aff6f947fb52673f8631744f285953b63b253898746f047809342931d::fufufafa {
    struct FUFUFAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFUFAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFUFAFA>(arg0, 9, b"FUFUFAFA", b"FuFa", b"Fufufafa mocked the 2019/2024 Indonesian presidential candidate, and in 2024, Fufufafa will even become the deputy of the president he insulted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c77241f-3311-43e1-8a6d-15f3ab9b9284.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFUFAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUFUFAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

