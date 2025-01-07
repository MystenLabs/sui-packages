module 0x9456830792ce7b82bdc6f95bc1ebfbc08379e3881d1f75754c91b2c175939149::tigerr {
    struct TIGERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERR>(arg0, 9, b"TIGERR", b"Tiger", b"Crying Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/adcc7f38-7b26-4c2c-a9c8-54d1fd3f0266.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

