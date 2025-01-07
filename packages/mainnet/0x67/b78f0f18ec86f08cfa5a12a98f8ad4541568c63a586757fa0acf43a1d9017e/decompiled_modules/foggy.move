module 0x67b78f0f18ec86f08cfa5a12a98f8ad4541568c63a586757fa0acf43a1d9017e::foggy {
    struct FOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGGY>(arg0, 6, b"FOGGY", b"Foggy ", x"6a7573742061206c696c2066726f6720696e20612062696720706f6e6420f09f90b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731449896305.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

