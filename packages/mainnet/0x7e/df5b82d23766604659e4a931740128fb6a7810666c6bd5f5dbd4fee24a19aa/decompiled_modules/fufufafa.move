module 0x7edf5b82d23766604659e4a931740128fb6a7810666c6bd5f5dbd4fee24a19aa::fufufafa {
    struct FUFUFAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFUFAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFUFAFA>(arg0, 9, b"FUFUFAFA", b"FuFa", b"Fufufafa mocked the 2019/2024 Indonesian presidential candidate, and in 2024, Fufufafa will even become the deputy of the president he insulted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3eeb3db2-0e66-4a87-a0e9-5a3910bf68ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFUFAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUFUFAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

