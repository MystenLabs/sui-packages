module 0x80fb5c0c5d8f2006f970f7bb2434d05b2d21f331a17e3f245077d27cabb86aa1::stwb {
    struct STWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STWB>(arg0, 9, b"STWB", b"Strawberry", x"4120737765657420616e64206c6976656c792063727970746f63757272656e6379207769746820612064656c6963696f7573207374726177626572727920636861726d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acf7429d-8ae4-4a17-9989-5c2345164979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

