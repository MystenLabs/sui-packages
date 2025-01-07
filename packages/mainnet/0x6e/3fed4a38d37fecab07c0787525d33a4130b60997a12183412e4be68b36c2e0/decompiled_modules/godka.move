module 0x6e3fed4a38d37fecab07c0787525d33a4130b60997a12183412e4be68b36c2e0::godka {
    struct GODKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODKA>(arg0, 9, b"GODKA", b"PeterGosp", b"A community based utility token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d093182f-a02f-48ee-a263-d55f2a529df2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

